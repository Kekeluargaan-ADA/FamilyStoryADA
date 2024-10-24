//
//  TemplateCollectionView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//

import SwiftUI

struct TemplateCollectionView: View {
    @StateObject private var viewModel = TemplateViewModel(templateUsecase: JSONTemplateUsecase())
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isModalPresented = false
    @State private var selectedTemplate: TemplateEntity?
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
                let heightRatio = ratios.heightRatio
                let widthRatio = ratios.widthRatio
                
                ZStack {
                    VStack {
                        Spacer()
                        ZStack(alignment: .bottom) {
                            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 40 * heightRatio, topTrailing: 40 * heightRatio))
                                .frame(height: 756 * heightRatio)
                                .foregroundStyle(Color("FSWhite"))
                                .overlay(
                                    VStack {
                                        TemplateCategoriesView(heightRatio: heightRatio, widthRatio: widthRatio) { category in
                                            viewModel.filterTemplates(by: category)
                                        }
                                        ScrollView {
                                            LazyVGrid(columns: columns, spacing: 20 * heightRatio) {
                                                ForEach(viewModel.filteredTemplates, id: \.templateId) { template in
                                                    TemplateCardView(template: template) {
                                                        selectedTemplate = template
                                                        isModalPresented = true
                                                    }
                                                }
                                            }
                                            .padding(46 * widthRatio)
                                        }
                                    }
                                )
                        }
                    }
                    if isModalPresented, let selectedTemplate = selectedTemplate {
                        PagePreviewModalView(template: selectedTemplate)
                        
                    }
                }
            }
            .background(Color("FSBlue6"))
            .ignoresSafeArea()
            .onAppear {
                viewModel.fetchTemplates()
                viewModel.filterTemplates(by: nil)
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
    }
}
