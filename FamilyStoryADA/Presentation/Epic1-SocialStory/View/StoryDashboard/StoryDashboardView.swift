//
//  StoryDashboardView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 12/10/24.
//

import SwiftUI
import SwiftData

struct StoryDashboardView: View {
    @State private var keywords: String = ""
    
    @StateObject private var viewModel: StoryViewModel = StoryViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
                let heightRatio = ratios.heightRatio
                let widthRatio = ratios.widthRatio
                
                ZStack(alignment: .top) {
                    ZStack(alignment: .top) {
                        StoryDashboardBackgroundSecondaryView(widthRatio: widthRatio, heightRatio: heightRatio)
                            .foregroundStyle(Color("FSYellow"))
//                            .padding(.top, 24 * heightRatio)
                            .padding(.horizontal, 24 * widthRatio)
//                            .ignoresSafeArea()
                        StoryDashboardBackgroundPrimaryView(widthRatio: widthRatio, heightRatio: heightRatio)
                            .foregroundStyle(Color("FSWhite"))
                            .padding(.top, 8 * heightRatio)
                            .padding(.horizontal, 24 * widthRatio)
//                            .ignoresSafeArea()
                    }
                    .frame(height: 804 * heightRatio)
                    .padding(.top, 30 * heightRatio)
                    
                    VStack {
                        HStack {
                            Text("Ceritaku")
                                .font(Font.custom("Fredoka", size: 40 * heightRatio, relativeTo: .largeTitle))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color("FSBlack"))
                                .padding(.leading, 40 * widthRatio)
                            Spacer()
                            HStack {
                                SearchBarView(searchText: $keywords, onCommit: {
                                    viewModel.searchText = keywords
                                    viewModel.searchStories()
                                }, searchPlaceholder: "Cari berdasarkan judul, kategori,...", width: 540, widthRatio: widthRatio, heightRatio: heightRatio)
                                ProfileButtonView(imageName: "", widthRatio: widthRatio, heightRatio: heightRatio)
                            }
                        }
                        .padding(.horizontal, 46 * widthRatio)
                        .padding(.top, 54 * heightRatio)
                        
                        ZStack {
                            VStack {
                                HStack (spacing: 14 * widthRatio) {
                                    Spacer()
                                    Text("Urutkan")
                                        .font(Font.custom("Fredoka", size: 16 * heightRatio))
                                        .foregroundStyle(Color("FSBlack"))
                                    DropdownFilterView(viewModel: viewModel, selectedOption: $viewModel.selectedOption, widthRatio: widthRatio, heightRatio: heightRatio)
                                }
                                ScrollView {
                                    LazyVGrid(columns: [
                                        GridItem(.fixed(354 * widthRatio), spacing: 15 * widthRatio),
                                        GridItem(.fixed(354 * widthRatio), spacing: 15 * widthRatio),
                                        GridItem(.fixed(354 * widthRatio))
                                    ], spacing: 26 * heightRatio) {
                                        ForEach (viewModel.displayedStory, id: \.storyId) { item in
                                            if !viewModel.stories.contains(where: {item.storyId == $0.storyId}) {
                                                Button(action: {
                                                    viewModel.isTemplateDashboardOpened = true
                                                }, label: {
                                                    NewStoryCardView(widthRatio: widthRatio, heightRatio: heightRatio)
                                                        
                                                })
                                            } else {
                                                ZStack(alignment: .topTrailing) {
                                                    Button(action: {
                                                        viewModel.currentlySelectedStory = item
                                                        viewModel.isCustomizationViewOpened = true
                                                    }, label: {
                                                        StoryCardView(
                                                            viewModel: viewModel,
                                                            storyName: item.storyName,
                                                            imagePath: item.storyCoverImagePath,
                                                            category: item.templateCategory,
                                                            storyLength: item.storyLength,
                                                            lastRead: item.storyLastRead,
                                                            story: item,
                                                            widthRatio: widthRatio,
                                                            heightRatio: heightRatio
                                                        )
                                                        .foregroundStyle(Color("FSBlack"))
                                                        
                                                    })
                                                    Menu {
                                                        Button(action: {
                                                            viewModel.currentlyEditedStory = item
                                                            viewModel.isEditCoverSheetOpened.toggle()
                                                        }) {
                                                            Label("Edit Cover", systemImage: "photo")
                                                        }
                                                        
                                                        Button(action: {
                                                            viewModel.deleteStory(storyId: item.storyId)
                                                        }) {
                                                            Label("Hapus Story", systemImage: "trash.fill")
                                                                .foregroundStyle(.red)
                                                        }
                                                    } label: {
                                                        Image(systemName: "ellipsis")
                                                            .font(.system(size: 24 * heightRatio))
                                                            .fontWeight(.bold)
                                                            .foregroundStyle(Color("FSBlack"))
                                                            .frame(width: 28 * widthRatio, height: 29 * heightRatio)
                                                            .padding(.trailing, 13 * widthRatio)
                                                            .padding(.top, 8 * heightRatio)
                                                    }
                                                    
                                                }
                                                
                                                //                                                .navigationViewStyle(.plain)
                                            }
                                        }
                                    }
                                    .padding(.top, 20 * heightRatio)
                                }
                            }
                            .padding(.top, 12 * heightRatio)
                            .padding(.horizontal, 46 * widthRatio)
                        }
                        .ignoresSafeArea()
                    }
                }
                .background(Color("FSBlue6"))
                .onAppear() {
                    //                    viewModel.addNewStory(templateId: UUID(uuidString: "819f2cc6-345d-4bfa-b081-2b0d4afc53ab") ?? UUID())
                    viewModel.fetchStories()
                }
                .sheet(isPresented: $viewModel.isEditCoverSheetOpened) {
                    if let story = Binding($viewModel.currentlyEditedStory) {
                        ZStack {
                            Color("FSBlue1")
                                .ignoresSafeArea()
                            EditCoverModalView(story: story,
                                               imageOptionPath: viewModel.getImagePreviewSelection(templateId: story.wrappedValue.templateId),
                                               widthRatio: widthRatio,
                                               heightRatio: heightRatio
                            )
                        }
                        .presentationDetents([.height(700 * heightRatio)])
                        .ignoresSafeArea(.keyboard)
                    }
                }
                .onChange(of: viewModel.currentlyEditedStory?.storyName) {
                    if let name = viewModel.currentlyEditedStory?.storyName {
                        guard let story = viewModel.stories.first(where: {$0.storyId == viewModel.currentlyEditedStory?.storyId}) else { return }
                        
                        story.storyName = name
                        
                        viewModel.updateStory(story: story)
                        viewModel.updateStoryDisplay()
                    }
                }
                .onChange(of: viewModel.currentlyEditedStory?.storyCoverImagePath) {
                    if let imagePath = viewModel.currentlyEditedStory?.storyCoverImagePath {
                        guard let story = viewModel.stories.first(where: {$0.storyId == viewModel.currentlyEditedStory?.storyId}) else { return }
                        
                        story.storyCoverImagePath = imagePath
                        
                        viewModel.updateStory(story: story)
                        viewModel.updateStoryDisplay()
                    }
                }
                NavigationLink(isActive: $viewModel.isTemplateDashboardOpened,
                               destination: {
                    TemplateCollectionView()
                        .environmentObject(viewModel)
                },
                               label: {
                    EmptyView()
                })
                NavigationLink(isActive: $viewModel.isCustomizationViewOpened, destination: {
                    if let story = viewModel.currentlySelectedStory{
                        CustomizationView(story: story)
                    } else {
                        EmptyView()
                    }
                }, label: {
                    EmptyView()
                })
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    StoryDashboardView()
}
