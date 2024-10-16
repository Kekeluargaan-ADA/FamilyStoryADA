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
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, buttonImage: "square.grid.2x2", text: "All") {
                    onCategorySelected(nil)
                }
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, buttonImage: "figure.walk", text: "Ambulating") {
                    onCategorySelected("Ambulating")
                }
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, buttonImage: "shower", text: "Hygiene") {
                    onCategorySelected("Hygiene")
                }
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, buttonImage: "fork.knife", text: "Feeding") {
                    onCategorySelected("Feeding")
                }
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, buttonImage: "tshirt", text: "Dressing") {
                    onCategorySelected("Dressing")
                }
                CategoryCircleView(heightRatio: heightRatio, widthRatio: widthRatio, buttonImage: "toilet", text: "Toileting") {
                    onCategorySelected("Toileting")
                }
            }
            .offset(y: 14 * heightRatio)
        }
        .padding(.horizontal, 46 * widthRatio)
        .padding(.top, -64 * heightRatio)
    }
}

#Preview {
    TemplateCategoriesView(heightRatio: 1, widthRatio: 1, onCategorySelected: {_ in })
}
