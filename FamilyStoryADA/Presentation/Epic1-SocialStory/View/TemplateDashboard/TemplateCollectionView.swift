//
//  TemplateCollectionView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//

import SwiftUI

struct TemplateCollectionView: View {
    @StateObject private var viewModel = TemplateViewModel(templateUsecase: JSONTemplateUsecase())

    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio

            VStack {
                Spacer()
                ZStack(alignment: .bottom) {
                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 40 * heightRatio, topTrailing: 40 * heightRatio))
                        .frame(height: 756 * heightRatio)
                        .foregroundStyle(.yellow)
                        .overlay(
                            VStack {
                                TemplateCategoriesView(heightRatio: heightRatio, widthRatio: widthRatio) { category in
                                    viewModel.filterTemplates(by: category)
                                }
                                ScrollView {
                                    LazyVGrid(columns: columns, spacing: 20 * heightRatio) {
                                        ForEach(viewModel.filteredTemplates, id: \.templateId) { template in
                                            TemplateCardView(template: template)
                                                .scaleEffect(1 * heightRatio)
                                        }
                                    }
                                    .padding(46 * widthRatio)
                                }
                            }
                        )
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.fetchTemplates()
            viewModel.filterTemplates(by: nil)
        }
    }
}

#Preview {
    TemplateCollectionView()
}
