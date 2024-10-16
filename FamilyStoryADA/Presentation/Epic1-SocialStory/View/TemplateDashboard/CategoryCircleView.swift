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
    let onTap: () -> Void

    var body: some View {
        Button(action: {
            onTap()
        }) {
            ButtonCircle(heightRatio: heightRatio, buttonImage: imageName)
                .overlay(
                    ZStack {
                        Text(text)
                            .offset(y: heightRatio * 48)
                    }
                )
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    CategoryCircleView(heightRatio: 1, widthRatio: 1, imageName: "photo.fill", text: "Text ", onTap: {})
}
