//
//  DeckView.swift
//  Set
//
//  Created by Jacob  on 13.02.2026.
//

import SwiftUI

struct DeckView: View {
    let cardCount: Int
    let isFaceUp: Bool
    
    
    var body: some View {
        ZStack {
            if cardCount > 0 {
                let base = RoundedRectangle(cornerRadius: 12)
                
                base
                    .fill(.white)
                
                base
                    .strokeBorder(.gray, lineWidth: 3)
                
                if isFaceUp {
                    Text("✓")
                        .font(.largeTitle)
                        .foregroundStyle(.green)
                } else {
                    Text("?")
                        .font(.largeTitle)
                        .foregroundStyle(.blue)
                }
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                    .foregroundStyle(.gray.opacity(0.3))
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
}

//#Preview {
//    DeckView()
//}
