//
//  GameTheme.swift
//  Memorize_1
//
//  Created by xcode on 16.01.2021.
//  Copyright © 2021 test. All rights reserved.
//

import SwiftUI

enum Themes: CaseIterable {
    case hallowen
    case sports
    case animals
    case food
    
    var game: GameTheme {
        switch self {
        case .hallowen:
            return GameTheme(name: "Hallowen", emojis: ["👻", "🎃", "🕷", "🧟‍♂️", "🍬","🧙‍♂️", "🍫", "🥧", "🥦", "🐲", "🕸", "🧚"], color: .orange)
        case .sports:
            return GameTheme(name: "Sports", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎","🏐", "🥏", "🏓", "⛳️", "🎾", "🏏", "🥊"], color: .red)
        case .animals:
            return GameTheme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐻", "🦊","🐨", "🐼", "🦁", "🐯", "🐮", "🐵", "🐝"], color: .green)
        case .food:
            return GameTheme(name: "Food", emojis: ["🍎", "🍊", "🥓", "🍉", "🍇","🍍", "🥑", "🍕", "🌽", "🥕", "🍗", "🌮"], color: .purple)
        }
    }
}

struct GameTheme {
    
    private(set) var name: String
    private(set) var emojis: Array<String>
    private(set) var color: Color
    private(set) var randomPairs: Bool = false
    
    var pairsToShow: Int {
        randomPairs ? Int.random(in: 2...5) : emojis.count
    }
}

