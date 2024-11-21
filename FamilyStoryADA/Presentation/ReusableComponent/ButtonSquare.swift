//
//  ExampleComponent.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 24/09/24.
//

import SwiftUI

struct ButtonSquare: View {
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    let buttonImage: String
    let text: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            Rectangle()
                .foregroundStyle(Color("FSWhite"))
                .frame(width: 153 * widthRatio, height: 133 * heightRatio)
                .cornerRadius(20 * heightRatio)
                .shadow(color: Color(.fsBlack).opacity(0.1), radius: 2, y: 4 * heightRatio)
                .overlay(
                    VStack {
                        Image(systemName: buttonImage)
                            .foregroundStyle(Color("FSBlue9"))
                            .font(.system(size: 40 * heightRatio))
                        Spacer().frame(height: 16 * heightRatio)
                        Text(text)
                            .font(Font.custom("Fredoka", size: 24 * heightRatio))
                          .foregroundColor(Color("FSBlack"))
                    }
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ButtonSquare(widthRatio: 1, heightRatio: 1, buttonImage: "photo", text: "Test", onTap: {})
}
