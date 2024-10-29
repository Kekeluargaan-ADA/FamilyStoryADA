//
//  TemplateCategoriesView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//

import SwiftUI

struct TemplateCategoriesView: View {
    @EnvironmentObject var viewModel: TemplateViewModel
    let heightRatio: CGFloat
    let widthRatio: CGFloat
    @State private var selectedCategory: String? = nil
    var onCategorySelected: (String?) -> Void
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    viewModel.isTemplateClosed = true
                }, label: {
                    ButtonCircle(heightRatio: heightRatio, buttonImage: "chevron.left", buttonColor: .blue)
                })
                Spacer()
            }
            HStack {
                CategoryCircleView(
                    heightRatio: heightRatio,
                    widthRatio: widthRatio,
                    buttonImage: "square.grid.2x2",
                    text: "All",
                    isSelected: selectedCategory == nil
                ) {
                    selectedCategory = nil
                    onCategorySelected(nil)
                }
                CategoryCircleView(
                    heightRatio: heightRatio,
                    widthRatio: widthRatio,
                    buttonImage: "figure.walk",
                    text: "Ambulating",
                    isSelected: selectedCategory == "Ambulating" //
                ) {
                    selectedCategory = "Ambulating"
                    onCategorySelected("Ambulating")
                }
                CategoryCircleView(
                    heightRatio: heightRatio,
                    widthRatio: widthRatio,
                    buttonImage: "shower",
                    text: "Hygiene",
                    isSelected: selectedCategory == "Hygiene"
                ) {
                    selectedCategory = "Hygiene"
                    onCategorySelected("Hygiene")
                }
                CategoryCircleView(
                    heightRatio: heightRatio,
                    widthRatio: widthRatio,
                    buttonImage: "fork.knife",
                    text: "Feeding",
                    isSelected: selectedCategory == "Feeding"
                ) {
                    selectedCategory = "Feeding"
                    onCategorySelected("Feeding")
                }
                CategoryCircleView(
                    heightRatio: heightRatio,
                    widthRatio: widthRatio,
                    buttonImage: "tshirt",
                    text: "Dressing",
                    isSelected: selectedCategory == "Dressing"
                ) {
                    selectedCategory = "Dressing"
                    onCategorySelected("Dressing")
                }
                CategoryCircleView(
                    heightRatio: heightRatio,
                    widthRatio: widthRatio,
                    buttonImage: "toilet",
                    text: "Toileting",
                    isSelected: selectedCategory == "Toileting"
                ) {
                    selectedCategory = "Toileting"
                    onCategorySelected("Toileting")
                }
            }
            .offset(y: 14 * heightRatio)
        }
        .padding(.horizontal, 46 * widthRatio)
        .padding(.top, -64 * heightRatio)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TemplateCategoriesView(heightRatio: 1, widthRatio: 1, onCategorySelected: { _ in })
}
