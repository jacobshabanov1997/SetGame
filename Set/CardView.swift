//
//  CardView.swift
//  Set
//
//  Created by Jacob  on 15.12.2025.
//

import SwiftUI

struct CardView: View {
    let card: SetCard
    let isPartOfMismatch: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12)
                
                base
                    .fill(.white)
                
                base
                    .strokeBorder(borderColor, lineWidth: 3)
                
                VStack(spacing: 2) {
                    ForEach(0..<card.numbersOfShapes.rawValue, id: \.self) { _ in
                        shapeView()
                            .frame(
                                    width: geometry.size.width * 0.6,
                                    height: geometry.size.height * 0.2
                            )
                    }
                }
                .padding()
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    @ViewBuilder
    private func shapeView() -> some View {
        switch card.shape {
        case .rectangle:
            applyShading(to: Rectangle())
        case .oval:
            applyShading(to: Capsule())
        case .diamond:
            applyShading(to: Diamond())
        }
    }
    
    @ViewBuilder
    private func applyShading(to shape: some Shape) -> some View {
        switch card.shading {
        case .solid:
            shape.fill(shapeColor)
        case .striped:
            shape.fill(shapeColor.opacity(0.3))
        case .open:
            shape.stroke(shapeColor, lineWidth: 2)
        }
    }
    
    private var borderColor: Color {
        if card.isMatched {
            return .green
        } else if card.isSelected {
            return isPartOfMismatch ? .red : .blue
        } else {
            return .gray
        }
    }
    
    private var selectedCardsColor: Color {
        return .blue
    }
    
    private var shapeColor: Color {
        switch card.color {
        case .red:
            return .red
        case .green:
            return .green
        case .purple:
            return .purple
        }
    }
}

//#Preview {
//    CardView()
//}
