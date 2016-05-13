//
//  AudioFilesDownloader.swift
//  Quran
//
//  Created by Mohamed Afifi on 5/14/16.
//  Copyright © 2016 Quran.com. All rights reserved.
//

import Foundation

protocol AudioFilesDownloader {

    func allFilesDownloaded(startAyah startAyah: AyahNumber, endAyah: AyahNumber, completion: (Bool) -> Void)

    func downloadFiles(startAyah startAyah: AyahNumber, endAyah: AyahNumber, completionHandler: Result<(), NetworkError> -> Void)
}
