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
    private let flexibleColumn = [
        GridItem(.fixed(354)),
        GridItem(.fixed(354)),
        GridItem(.fixed(354))
    ]
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    ZStack {
                        StoryDashboardBackgroundView()
                            .foregroundStyle(Color("FSYellow"))
                            .padding(.top, 30)
                            .padding(.horizontal, 24)
                            .ignoresSafeArea()
                        StoryDashboardBackgroundView()
                            .foregroundStyle(Color("FSWhite"))
                            .padding(.top, 38)
                            .padding(.horizontal, 24)
                            .ignoresSafeArea()
                    }
                    .frame(height: 804)
                    VStack {
                        HStack {
                            Text("My Story")
                                .font(Font.custom("Fredoka", size: 40, relativeTo: .largeTitle))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color("FSBlack"))
                            Spacer(minLength: geometry.size.width / 2)
                            HStack {
                                SearchBarView(searchText: $keywords, onCommit: {
                                                                    viewModel.searchText = keywords
                                                                    viewModel.searchStories() // Trigger search when user commits
                                                                })
                                ProfileButtonView(imageName: "")
                            }
                        }
                        .padding(.horizontal, 46)
                        .padding(.top, 24)
                        ZStack {
                            VStack {
                                HStack (spacing: 12) {
                                    Spacer()
                                    Text("Urutkan")
                                        .foregroundStyle(.black)
                                    DropdownFilterView(viewModel: viewModel, selectedOption: $viewModel.selectedOption)
                                }
                                .padding(.horizontal, 20)
                                ScrollView {
                                    LazyVGrid(columns: flexibleColumn, spacing: 26) {
                                        ForEach (viewModel.displayedStory, id: \.storyId) { item in
                                            if !viewModel.stories.contains(where: {item.storyId == $0.storyId}) {
                                                NavigationLink(destination: TemplateCollectionView()) {
                                                    NewStoryCardView()
                                                        .padding(.horizontal, 10)
                                                }
                                            } else {
                                                ZStack(alignment: .topTrailing) {
                                                    NavigationLink(destination: CustomizationView(story: item),
                                                                   label: {
                                                        StoryCardView(
                                                            viewModel: viewModel,
                                                            storyName: item.storyName,
                                                            imagePath: item.storyCoverImagePath,
                                                            category: item.templateCategory,
                                                            storyLength: item.storyLength,
                                                            lastRead: item.storyLastRead,
                                                            story: item
                                                        )
                                                        .foregroundStyle(Color("FSBlack"))
                                                        .padding(.horizontal, 10)
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
                                                            .font(.system(size: 24))
                                                            .fontWeight(.bold)
                                                            .foregroundStyle(Color("FSBlack"))
                                                            .padding()
                                                    }
                                                    
                                                }
                                                
                                                //                                                .navigationViewStyle(.plain)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.top, 12)
                            .padding(.horizontal, 22)
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
                            EditCoverModalView(story: story, imageOptionPath: viewModel.getImagePreviewSelection(templateId: story.wrappedValue.templateId))
                        }
                        .presentationDetents([.height(700)])
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
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    StoryDashboardView()
}
