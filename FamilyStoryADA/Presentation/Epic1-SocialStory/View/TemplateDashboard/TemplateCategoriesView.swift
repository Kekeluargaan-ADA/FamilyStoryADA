//
//  TemplateCategoriesView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//

import SwiftUI

struct TemplateCategoriesView: View {
    let heightRatio: CGFloat
    let widthRatio: CGFloat
    
    var body: some View {
        ZStack {
            HStack {
                Circle()
                    .foregroundStyle(.gray)
                    .frame(width: 64, height: 64)
                Spacer()
            }
            HStack(spacing: 12 * widthRatio) {
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, imageName: "photo.fill", text: "Test")
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, imageName: "photo.fill", text: "Test")
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, imageName: "photo.fill", text: "Test")
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, imageName: "photo.fill", text: "Test")
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, imageName: "photo.fill", text: "Test")
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, imageName: "photo.fill", text: "Test")
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, imageName: "photo.fill", text: "Test")
            }
        }
        .padding(.horizontal, 46 * widthRatio)
        .padding(.top, -32 * heightRatio)
    }
}

#Preview {
    TemplateCategoriesView(heightRatio: 1.0, widthRatio: 1.0)
}
