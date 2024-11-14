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
                    ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "chevron.left", buttonColor: .blue)
                })
                Spacer()
            }
            HStack {
                CategoryCircleView(
                    heightRatio: heightRatio,
                    widthRatio: widthRatio,
                    buttonImage: "square.grid.2x2",
                    text: "Semua",
                    isSelected: selectedCategory == nil
                ) {
                    selectedCategory = nil
                    onCategorySelected(nil)
                }
                CategoryCircleView(
                    heightRatio: heightRatio,
                    widthRatio: widthRatio,
                    buttonImage: "figure.walk",
                    text: "Bergerak",
                    isSelected: selectedCategory == "Bergerak" //
                ) {
                    selectedCategory = "Bergerak"
                    onCategorySelected("Bergerak")
                }
                CategoryCircleView(
                    heightRatio: heightRatio,
                    widthRatio: widthRatio,
                    buttonImage: "shower",
                    text: "Kebersihan",
                    isSelected: selectedCategory == "Kebersihan"
                ) {
                    selectedCategory = "Kebersihan"
                    onCategorySelected("Kebersihan")
                }
                CategoryCircleView(
                    heightRatio: heightRatio,
                    widthRatio: widthRatio,
                    buttonImage: "fork.knife",
                    text: "Makan",
                    isSelected: selectedCategory == "Makan"
                ) {
                    selectedCategory = "Makan"
                    onCategorySelected("Makan")
                }
                CategoryCircleView(
                    heightRatio: heightRatio,
                    widthRatio: widthRatio,
                    buttonImage: "tshirt",
                    text: "Berpakaian",
                    isSelected: selectedCategory == "Berpakaian"
                ) {
                    selectedCategory = "Berpakaian"
                    onCategorySelected("Berpakaian")
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
