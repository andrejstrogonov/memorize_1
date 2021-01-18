//
//  Array+Identifible.swift
//  Memorize_1
//
//  Created by xcode on 16.01.2021.
//  Copyright © 2021 test. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        self.firstIndex(where: { $0.id == matching.id })
    }
}
