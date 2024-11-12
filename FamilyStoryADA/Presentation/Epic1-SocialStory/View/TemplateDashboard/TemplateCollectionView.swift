//
//  TemplateCollectionView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//

import SwiftUI

struct TemplateCollectionView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = TemplateViewModel()
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var storyViewModel: StoryViewModel
    
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
                                        .environmentObject(viewModel)
                                        ScrollView {
                                            LazyVGrid(columns: columns, spacing: 20 * heightRatio) {
                                                ForEach(viewModel.filteredTemplates, id: \.templateId) { template in
                                                    TemplateCardView(template: template) {
                                                        viewModel.selectedTemplate = template
                                                        viewModel.isPagePreviewModalPresented = true
                                                    }
                                                }
                                            }
                                            .padding(46 * widthRatio)
                                        }
                                    }
                                )
                        }
                    }
                    if viewModel.isPagePreviewModalPresented, let template = Binding($viewModel.selectedTemplate) {
                        PagePreviewModalView()
                            .environmentObject(viewModel)
                        
                    }
                }
            }
            .background(Color("FSBlue6"))
            .ignoresSafeArea()
            .onAppear {
                viewModel.fetchTemplates()
                viewModel.filterTemplates(by: nil)
            }
            .onChange(of: viewModel.isTemplateClosed) { value in
                if value {
                    storyViewModel.currentlySelectedStory = viewModel.createdStory
                    if viewModel.createdStory != nil {
                        storyViewModel.isCustomizationViewOpened = true
                    }
                    storyViewModel.isTemplateDashboardOpened = false
                }
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
    }
}
