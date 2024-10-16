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
    let buttonImage: String
    let text: String
    let onTap: () -> Void
    
    var body: some View {
        ButtonCircle(heightRatio: heightRatio, buttonImage: buttonImage, onTap: onTap)
            .overlay(
                ZStack {
                    Text(text)
                        .offset(y: heightRatio * 48)
                }
            )
    }
}


#Preview {
    CategoryCircleView(heightRatio: 1, widthRatio: 1, buttonImage: "photo.fill", text: "Text ", onTap: {})
}
