//
//  LastAyahFinder.swift
//  Quran
//
//  Created by Mohamed Afifi on 5/13/16.
//  Copyright © 2016 Quran.com. All rights reserved.
//

import Foundation

protocol LastAyahFinder {
    func findLastAyah(startAyah: AyahNumber, page: Int) -> AyahNumber
}
