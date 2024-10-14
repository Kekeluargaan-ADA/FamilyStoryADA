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
    
    var body: some View {
        Circle()
            .foregroundStyle(.gray)
            .frame(height: 64)
            .overlay(
                ZStack {
                    Image(systemName: imageName)
                    Text(text)
                        .offset(y: 48)
                }
            )
    }
}

#Preview {
    CategoryCircleView(heightRatio: 1, widthRatio: 1, imageName: "photo.fill", text: "Text ")
}