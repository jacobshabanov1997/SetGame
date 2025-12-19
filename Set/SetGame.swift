//
//  SetGame.swift
//  Set
//
//  Created by Jacob  on 05.12.2025.
//

import Foundation

struct SetCard: Identifiable {
    let id: Int
    let numbersOfShapes: NumbersOfShapes
    let shape: Shape
    let shading: Shading
    let color: Color
    
    var isSelected: Bool = false
    var isMatched: Bool = false
    
    enum NumbersOfShapes: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }
    
    enum Shape: CaseIterable {
        case diamond
        case rectangle
        case oval
    }
    
    enum Shading: CaseIterable {
        case solid
        case striped
        case open
    }
    
    enum Color: CaseIterable {
        case red
        case green
        case purple
    }
}

struct SetGame {
    private(set) var deck: [SetCard]
    private(set) var cardsInPlay: [SetCard]
    
    init() {
        var cards: [SetCard] = []
        var cardId = 0
        
        for number in SetCard.NumbersOfShapes.allCases {
            for shape in SetCard.Shape.allCases {
                for shading in SetCard.Shading.allCases {
                    for color in SetCard.Color.allCases {
                        let card = SetCard(
                            id: cardId,
                            numbersOfShapes: number,
                            shape: shape,
                            shading: shading,
                            color: color
                        )
                        cards.append(card)
                        cardId += 1
                    }
                }
            }
        }
        
        self.deck = cards.shuffled()
        self.cardsInPlay = Array(deck.prefix(12))
        self.deck.removeFirst(12)
    }
    
    mutating func choose(_ card: SetCard) {
        guard let chosenIndex = cardsInPlay.firstIndex(where: { $0.id == card.id }) else { return
        }
        
        if selectedCards.count == 3 {
            handleThreeCardsSelected(choosingCardAt: chosenIndex)
        } else {
            cardsInPlay[chosenIndex].isSelected.toggle()
        }
    }
    
    private mutating func handleThreeCardsSelected(choosingCardAt index: Int) {
        let threeCards = selectedCards
        
        if isSet(threeCards) {
            for card in threeCards {
                if let cardIndex = cardsInPlay.firstIndex(where: { $0.id == card.id }) {
                    cardsInPlay[cardIndex].isMatched = true
                    cardsInPlay[cardIndex].isSelected = false
                }
            }
            
            replaceMatchedCards()
            
            if !threeCards.contains(where: { $0.id == cardsInPlay[index].id }) {
                cardsInPlay[index].isSelected = true
            }
        } else {
            for card in threeCards {
                if let cardIndex = cardsInPlay.firstIndex(where: { $0.id == card.id }) {
                    cardsInPlay[cardIndex].isSelected = false
                }
            }
            cardsInPlay[index].isSelected = true
        }
        
        if !cardsInPlay[index].isMatched {
            cardsInPlay[index].isSelected = true
        }
    }
    
    mutating func replaceMatchedCards() {
        let matchedCards = cardsInPlay.filter({ $0.isMatched })
        guard !matchedCards.isEmpty else { return }
        cardsInPlay.removeAll { $0.isMatched }
        let numberOfCardsToAdd = min(matchedCards.count, deck.count)
        
        if numberOfCardsToAdd > 0 {
            let newCards = Array(deck.prefix(numberOfCardsToAdd))
            cardsInPlay.append(contentsOf: newCards)
            deck.removeFirst(numberOfCardsToAdd)
        }
    }
    
    mutating func dealThreeMoreCards() {
        if selectedCards.count == 3 && isSet(selectedCards) {
            replaceMatchedCards()
        } else {
            let numberOfCardsToAdd = min(3, deck.count)
            
            if numberOfCardsToAdd > 0 {
                let newCards = Array(deck.prefix(numberOfCardsToAdd))
                cardsInPlay.append(contentsOf: newCards)
                deck.removeFirst(numberOfCardsToAdd)
            }
        }
    }
    
    mutating func newGame() {
        self = SetGame()
    }
    
    var selectedCards: [SetCard] {
        cardsInPlay.filter { $0.isSelected }
    }
    
    func isSet(_ cards: [SetCard]) -> Bool {
        guard cards.count == 3 else { return false }
        
        let numbers = Set(cards.map { $0.numbersOfShapes.rawValue })
        let shapes = Set(cards.map { $0.shape })
        let shading = Set(cards.map { $0.shading })
        let colors = Set(cards.map { $0.color })
        
        return (numbers.count == 1 || numbers.count == 3) &&
        (shapes.count == 1 || shapes.count == 3) &&
        (shading.count == 1 || shading.count == 3) &&
        (colors.count == 1 || colors.count == 3)
    }
}
