//
//  ContentView.swift
//  Set
//
//  Created by Jacob  on 05.12.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SetGameViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text("Set Game")
                    .font(.largeTitle)
                    .bold()
                
                Text("Cards in deck: \(viewModel.deckCount)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 120))], spacing: 4) {
                        ForEach(viewModel.cardsInPlay) { card in
                            CardView(
                                card: card,
                                isPartOfMismatch: viewModel.isMismatch && viewModel.selectedCards.contains(where: { $0.id == card.id })
                            )
                                .onTapGesture {
                                    viewModel.choose(card)
                                }
                            }
                        }
                        .padding()
                    }
                
            HStack(spacing: 20) {
                    Button {
                        viewModel.dealThreeMoreCards()
                    } label: {
                        Text("Deal 3 More")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.deckCount > 0 ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(viewModel.deckCount == 0)
                    
                    Button {
                        viewModel.newGame()
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
}

//#Preview {
//    ContentView()
//}
