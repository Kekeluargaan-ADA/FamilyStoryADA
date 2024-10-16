//
//  CategoryCircleView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//

import SwiftUI

struct CategoryCircleView: View {
    let heightRatio: CGFloat
    let widthRatio: CGFloat
    let imageName: String
    let text: String
    let onTap: () -> Void // Closure for handling button tap

    var body: some View {
        Button(action: {
            onTap() // Call the closure when the button is tapped
        }) {
            Circle()
                .foregroundStyle(.gray)
                .frame(width: 64 * widthRatio, height: 64 * heightRatio)
                .overlay(
                    ZStack {
                        Image(systemName: imageName)
                        Text(text)
                            .offset(y: 48)
                    }
                )
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    CategoryCircleView(heightRatio: 1, widthRatio: 1, imageName: "photo.fill", text: "Text ", onTap: {})
}
