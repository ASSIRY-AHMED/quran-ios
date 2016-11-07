//
//  QariTimingRetriever.swift
//  Quran
//
//  Created by Mohamed Afifi on 5/20/16.
//  Copyright © 2016 Quran.com. All rights reserved.
//

import Foundation

protocol QariTimingRetriever {
    func retrieveTimingForQari(_ qari: Qari, startAyah: AyahNumber, onCompletion: @escaping (Result<[AyahNumber: AyahTiming]>) -> Void)

    func retrieveTimingForQari(_ qari: Qari, suras: [Int], onCompletion: @escaping (Result<[Int: [AyahTiming]]>) -> Void)
}
