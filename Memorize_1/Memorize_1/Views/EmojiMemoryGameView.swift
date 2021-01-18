//
//  EmojiMemoryGameView.swift
//  Memorize_1
//
//  Created by xcode on 16.01.2021.
//  Copyright © 2021 test. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiMemoryGameVM: EmojiMemoyGame
    var body: some View {
        VStack {
            Text("\(emojiMemoryGameVM.themeName)")
                .font(.largeTitle)
            Text("Score: \(emojiMemoryGameVM.score)")
                .font(.title)
            GridView(items: emojiMemoryGameVM.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)){
                        self.emojiMemoryGameVM.choose(card: card)
                    }
                }
            }
            Button("New Game", action: {
                withAnimation(.easeInOut(duration: 2)) {
                    self.emojiMemoryGameVM.newGame()
                }
            })
                .buttonStyle(GradientButtonStyle(color: emojiMemoryGameVM.themeColor))
        }
            .padding(5)
            .foregroundColor(emojiMemoryGameVM.themeColor)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            internalCardifyBody(for: size)
                .cardify(isFaceUp: card.isFaceUp)
                .padding(5)
        }
    }
    
    private func internalCardifyBody(for size: CGSize) -> some View {
        ZStack {
            Group {
                if card.isConsumingBonusTime {
                    Pie(
                        startAngle: Angle.degrees(0-90),
                        endAngle: Angle.degrees(-animatedBonusRemaining*360-90),
                        clockwise: true
                    )
                        .onAppear() {
                            self.startBonusTimeAnimation()
                        }
                } else {
                    Pie(
                        startAngle: Angle.degrees(0-90),
                        endAngle: Angle.degrees(-card.bonusRemaining*360-90),
                        clockwise: true
                    )
                        
                }
            }
                .padding(6)
                .opacity(0.33)
            Text(card.content)
                .font(Font.system(size: fontSize(for: size)))
                .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default) 
        }
    }
    
    //MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.65
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoyGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(emojiMemoryGameVM: game)
    }
}
#endif
