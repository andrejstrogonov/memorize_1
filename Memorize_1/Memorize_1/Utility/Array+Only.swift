//
//  Array+Only.swift
//  Memorize_1
//
//  Created by xcode on 16.01.2021.
//  Copyright © 2021 test. All rights reserved.
//

import Foundation

extension Array {
    
    var only: Element? {
        count == 1 ? first : nil
    }
    
}
