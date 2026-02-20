//
//  SetGameViewModel.swift
//  Set
//
//  Created by Jacob  on 05.12.2025.
//

import SwiftUI
internal import Combine

class SetGameViewModel: ObservableObject {
    @Published private var model = SetGame()
    
    // MARK: - Access to Model
    
    var cardsInPlay: [SetCard] {
        model.cardsInPlay
    }
    
    var deckCount: Int {
        model.deck.count
    }
    
    var discardedCount: Int {
        model.discardedCards.count
    }
    
    var deckCards: [SetCard] {
        model.deck
    }
    
    var discardedCards: [SetCard] {
        model.discardedCards
    }
    
    var selectedCards: [SetCard] {
        model.selectedCards
    }
    
    var isMismatch: Bool {
        let selected = model.selectedCards
        return selected.count == 3 && !model.isSet(selected)
    }
    
    // MARK: - Intents
    
    func choose(_ card: SetCard) {
        model.choose(card)
    }
    
    func dealThreeMoreCards() {
        model.dealThreeMoreCards()
    }
    
    func newGame() {
        model.newGame()
    }
    
    func shuffle() {
        withAnimation {
            model.shuffle()
        }
    }
}
