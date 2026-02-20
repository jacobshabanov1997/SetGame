//
//  ContentView.swift
//  Set
//
//  Created by Jacob  on 05.12.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SetGameViewModel()
    @Namespace private var cardNamespace
    
    var body: some View {
        VStack(spacing: 0) {
            
            Text("Set Game")
                .font(.largeTitle)
                .bold()
                .padding()
            
            HStack {
                VStack {
                    ZStack {
                        ForEach(viewModel.deckCards) { card in
                            CardView(card: card, isPartOfMismatch: false)
                                .matchedGeometryEffect(id: card.id, in: cardNamespace)
                                .frame(width: 80, height: 120)
                                .opacity(0)
                        }
                        
                        DeckView(cardCount: viewModel.deckCount, isFaceUp: false)
                            .frame(width: 80, height: 120)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.dealThreeMoreCards()
                                }
                            }
                    }
                    Text("Deck: \(viewModel.deckCount)")
                        .font(.caption)
                }
                
                Spacer()
                
                VStack {
                    ZStack {
                        
                        ForEach(viewModel.discardedCards) { card in
                            CardView(card: card, isPartOfMismatch: false)
                                .matchedGeometryEffect(id: card.id, in: cardNamespace)
                                .frame(width: 80, height: 120)
                                .opacity(0)
                        }
                        
                        DeckView(cardCount: viewModel.discardedCount, isFaceUp: true)
                            .frame(width: 80, height: 120)
                    }
                    Text("Discarded: \(viewModel.discardedCount)")
                        .font(.caption)
                }
            }
        }
        .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 120))], spacing: 4) {
                    ForEach(viewModel.cardsInPlay) { card in
                        CardView(
                            card: card,
                            isPartOfMismatch: viewModel.isMismatch && viewModel.selectedCards.contains(where: { $0.id == card.id })
                        )
                        .matchedGeometryEffect(id: card.id, in: cardNamespace)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                        .transition(.identity)
                    }
                }
                .animation(.default, value: viewModel.cardsInPlay.count)
                .padding()
            }
            
            HStack(spacing: 20) {
                Button {
                    viewModel.shuffle()
                } label: {
                    Text("Shuffle")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
                
                Button {
                    withAnimation {
                        viewModel.newGame()
                    }
                } label: {
                    Text("New Game")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }


//#Preview {
//    ContentView()
//}
