//
//  Download+Types.swift
//  Quran
//
//  Created by Mohamed Afifi on 3/1/17.
//  Copyright © 2017 Quran.com. All rights reserved.
//

import Foundation

extension Download {
    var isTranslation: Bool {
        return destinationPath.hasPrefix(Files.translationsPathComponent)
    }
}

extension Download {
    var isAudio: Bool {
        return !isTranslation
    }
}
