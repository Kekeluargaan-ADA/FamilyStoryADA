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
    var onCategorySelected: (String?) -> Void 
    
    var body: some View {
        ZStack {
            HStack {
                ButtonCircle(heightRatio: heightRatio, buttonImage: "chevron.left", onTap: {})
                Spacer()
            }
            HStack() {
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, buttonImage: "photo.fill", text: "All") {
                    onCategorySelected(nil)
                }
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, buttonImage: "photo.fill", text: "Ambulating") {
                    onCategorySelected("Ambulating")
                }
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, buttonImage: "photo.fill", text: "Hygiene") {
                    onCategorySelected("Hygiene")
                }
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, buttonImage: "photo.fill", text: "Feeding") {
                    onCategorySelected("Feeding")
                }
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, buttonImage: "photo.fill", text: "Dressing") {
                    onCategorySelected("Dressing")
                }
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, buttonImage: "photo.fill", text: "Toileting") {
                    onCategorySelected("Toileting")
                }
            }
            .offset(y: 14 * heightRatio)
        }
        .padding(.horizontal, 46 * widthRatio)
        .padding(.top, -32 * heightRatio)
    }
}

#Preview {
    TemplateCategoriesView(heightRatio: 1, widthRatio: 1, onCategorySelected: {_ in })
}
