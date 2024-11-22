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
                            VStack {
                                TemplateCategoriesView(heightRatio: heightRatio, widthRatio: widthRatio) { category in
                                    viewModel.filterTemplates(by: category)
                                }
                                .environmentObject(viewModel)
                                ScrollView {
                                    LazyVGrid(columns: [
                                        GridItem(.fixed(354 * widthRatio), spacing: 20 * widthRatio),
                                        GridItem(.fixed(354 * widthRatio), spacing: 20 * widthRatio),
                                        GridItem(.fixed(354 * widthRatio))
                                    ], spacing: 26 * heightRatio) {
                                        ForEach(viewModel.filteredTemplates, id: \.templateId) { template in
                                            TemplateCardView(template: template, widthRatio: widthRatio, heightRatio: heightRatio) {
                                                viewModel.selectedTemplate = template
                                                viewModel.isPagePreviewModalPresented = true
                                            }
                                        }
                                    }
                                    .padding(46 * widthRatio)
                                }
                            }
                        }
                    }
                    if viewModel.isPagePreviewModalPresented, let _ = Binding($viewModel.selectedTemplate) {
                        PagePreviewModalView(widthRatio: widthRatio, heightRatio: heightRatio)
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
            .onChange(of: viewModel.isTemplateClosed) { _, value in
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
