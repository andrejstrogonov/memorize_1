//
//  EmojiMemoryGame.swift
//  Memorize_1
//
//  Created by xcode on 16.01.2021.
//  Copyright © 2021 test. All rights reserved.
//

import SwiftUI
import Combine

class EmojiMemoyGame: ObservableObject {
    @Published private var gameModel: MemoryGame<String> = EmojiMemoyGame.createMemoryGame()
    private(set) var score: Int = 0
    private var temporalScore: Int = 0
    private static func createMemoryGame() -> MemoryGame<String> {
        let theme = EmojiMemoyGame.addTheme()
        let emojis: Array<String> = theme.emojis.shuffled()
        return MemoryGame<String>(theme: theme, numberOfPairsOfCards: theme.pairsToShow) { pairIndex in emojis[pairIndex]
        }
    }
    
    private static func addTheme() -> GameTheme {
        Themes.allCases.map({ $0.game }).shuffled()[0]
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        gameModel.cards
    }
    
    var amountOfPairs: Int {
        gameModel.cards.count/2
    }
    
    var themeColor: Color {
        gameModel.theme.color
    }
    
    var themeName: String {
        gameModel.theme.name
    }
    
    // MARK: - Intent(s)
    
    func newGame() {
        gameModel = EmojiMemoyGame.createMemoryGame()
        score = 0
    }
    
    func choose(card: MemoryGame<String>.Card) {
        gameModel.choose(card: card)
        
        temporalScore += card.seen ? -1 : 0
        
        if !gameModel.currentyPlaying {
            if let selectedCard = cards.first(where: { $0.id == card.id }) {
                score += selectedCard.isMatched ? 2 : temporalScore
                temporalScore = 0
            }
        }
    }
    
}
