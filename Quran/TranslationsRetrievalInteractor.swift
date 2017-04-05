//
//  TranslationsRetrievalInteractor.swift
//  Quran
//
//  Created by Mohamed Afifi on 2/26/17.
//  Copyright © 2017 Quran.com. All rights reserved.
//

import Foundation
import PromiseKit

class TranslationsRetrievalInteractor: Interactor {

    private let networkManager: AnyNetworkManager<[Translation]>
    private let persistence: ActiveTranslationsPersistence
    private let downloader: DownloadManager
    init(networkManager: AnyNetworkManager<[Translation]>, persistence: ActiveTranslationsPersistence, downloader: DownloadManager) {
        self.networkManager = networkManager
        self.persistence = persistence
        self.downloader = downloader
    }

    func execute(_ input: Void) -> Promise<[TranslationFull]> {

        let local = Queue.translations.queue.promise { [weak self] (Void) -> [Translation] in
            guard let `self` = self else { return [] }
            return try self.persistence.retrieveAll()
        }
        let remote = networkManager.execute(.translations)

        return when(fulfilled: local, remote)
            .then(on: .background) { local, remote -> ([Translation], [Int: Translation]) in
                let combined = combine(local: local, remote: remote)
                let localMap = local.flatGroup { $0.id }
                return (combined, localMap)
            }.then(on: Queue.translations.queue) { [weak self] (translations, localMap) -> [Translation] in
                guard let `self` = self else { return [] }

                try translations.forEach { translation in
                    if localMap[translation.id] != nil {
                        try self.persistence.update(translation)
                    } else {
                        try self.persistence.insert(translation)
                    }
                }
                return translations
            }.then { [weak self] translations -> ([Translation], [DownloadNetworkResponse]) in
                let batches = self?.downloader.getOnGoingDownloads()
                let downloads = batches?.flatMap { $0.filter { $0.download.isTranslation } }
                return (translations, downloads ?? [])
            }.then(on: .background) { (translations, downloads) -> [TranslationFull] in
                return TranslationFull.createTransltionsFull(translations, downloads: downloads)
        }
    }
}

private func combine(local: [Translation], remote: [Translation]) -> [Translation] {
    var localMap = local.flatGroup { $0.id }

    var combinedList: [Translation] = []
    remote.forEach { remote in
        var combined = remote
        if let local = localMap[remote.id] {
            combined.installedVersion = local.installedVersion
            localMap[remote.id] = nil
        }
        combinedList.append(combined)
    }
    combinedList.append(contentsOf: localMap.map { $1})
    return combinedList
}
