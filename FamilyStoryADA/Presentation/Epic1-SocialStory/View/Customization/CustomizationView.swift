//
//  CustomizationView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import SwiftUI
import AVKit

struct CustomizationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: PageCustomizationViewModel
    
    @State var currentText: String = ""
    @State private var typingTimer: Timer? = nil
    
    init(story: StoryEntity) {
        _viewModel = StateObject(wrappedValue: PageCustomizationViewModel(story: story))
    }
    
    var body: some View {
        HStack {
            VStack(spacing: 32) {
                Button(action: {
                    viewModel.updatePage()
                    dismiss()
                }, label: {
                    CustomizedBackButton()
                })
                DraggablePageCustomizationSelectionView(draggedPages: $viewModel.draggedPages)
            }
            
            ZStack {
                ZStack(alignment: .top) {
                    Image("CustomizationBackground")
                    ZStack (alignment: .center) {
                        RoundedRectangle(cornerRadius: 28)
                            .fill(Color("FSYellow"))
                        Text(viewModel.story.storyName)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(Color("FSBlack"))
                    }
                    .frame(width: 268, height: 45)
                    VStack(spacing: 48) {
                        HStack {
                            if viewModel.selectedPage != nil {
                                Button(action: {
                                    viewModel.deletePage()
                                }, label: {
                                    ButtonCircle(heightRatio: 1.0, buttonImage: "trash", buttonColor: .blue)
                                })
                            }
                            
                            Spacer()
                            //TODO: Disable when page is null
                            HStack (spacing: 12) {
                                NavigationLink(destination: {
                                    PlayStoryView(story: viewModel.story)
                                }, label: {
                                    ButtonCircle(heightRatio: 1.0, buttonImage: "play", buttonColor: .blue)
                                })
                                //                                .disabled(!viewModel.draggedPages.isEmpty) // MARK: Not working
                                
                                NavigationLink(destination: {
                                    MiniQuizView(story: viewModel.story)
                                }, label: {
                                    ButtonCircle(heightRatio: 1.0, buttonImage: "gamecontroller", buttonColor: .blue)
                                })
                                //                                .disabled(!viewModel.draggedPages.isEmpty) // MARK: Not working
                            }
                        }
                        .padding(.top, 20)
                        .padding(.horizontal, 46)
                        
                        if let page = viewModel.selectedPage {
                            VStack(alignment: .center, spacing: 19) {
                                if page.pagePicture.first?.componentCategory == "AssetPicture", let imagePath = page.pagePicture.first?.componentContent {
                                    Image(imagePath)
                                        .resizable()
                                        .frame(width: 760, height: 468)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                } else if !page.pageVideo.isEmpty, let videoComponent = page.pageVideo.first, let url = Bundle.main.url(forResource: videoComponent.componentContent, withExtension: "mp4") {
                                    
                                        let videoPlayer = AVPlayer(url: url)
                                    
                                    VideoPlayer(player: videoPlayer)
                                        .frame(width: 760, height: 468)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .onAppear() {
                                            
                                            videoPlayer.play()
                                            
                                        }
                                        .onDisappear() {
                                            videoPlayer.pause()
                                        }
                                    
                                } else {
                                    Button(action: {
                                        // TODO: Pop up menu
                                    }, label: {
                                        EmptyImageCustomizationView()
                                    })
                                }
                                
                                TextField("Masukkan teks di sini", text: Binding(
                                    get: { currentText },
                                    set: { newValue in
                                        currentText = newValue
                                        resetTypingTimer()
                                    }
                                ))
                                .padding(.horizontal, 19)
                                .padding(.vertical, 15)
                                .frame(width: 760, height: 117)
                                .font(.system(size: 32, weight: .semibold))
                                .foregroundStyle(Color("FSBlack"))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color("FSBorderBlue7"), lineWidth: 2)
                                )
                                .onAppear {
                                    currentText = page.pageText.first?.componentContent ?? ""
                                }
                                
                            }
                        }
                    }
                }
            }
        }
        .padding(.top, 26)
        .ignoresSafeArea()
        .background(Color("FSBlue6"))
        .navigationBarBackButtonHidden()
        .environmentObject(viewModel)
        .onChange(of: viewModel.selectedPage) { newSelectedPage in
            if let newPage = newSelectedPage {
                currentText = newPage.pageText.first?.componentContent ?? ""
            } else {
                currentText = ""
            }
        }
    }
    
    // Reset and start the timer for delayed update
    func resetTypingTimer() {
        typingTimer?.invalidate()
        typingTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            updatePageText()
        }
    }
    
    // Update the page text when the timer completes
    func updatePageText() {
        // TODO: Notify to update SwiftData model
        if let selectedPage = viewModel.selectedPage, !selectedPage.pageText.isEmpty {
            selectedPage.pageText.first?.componentContent = currentText
        } else {
            viewModel.selectedPage?.pageText = []
            viewModel.selectedPage?.pageText.append(TextComponentEntity(componentId: UUID(),
                                                                        componentContent: currentText,
                                                                        componentCategory: "Text"
                                                                       ))
        }
    }
}

#Preview {
    CustomizationView(story: StoryEntity(storyId: UUID(),
                                         storyName: "ABC",
                                         storyCoverImagePath: "DummyImage",
                                         storyLastRead: Date(),
                                         templateId: UUID(),
                                         templateCategory: "Hygiene",
                                         pages: [
                                            PageEntity(pageId: UUID(),
                                                       pageText: [
                                                        TextComponentEntity(componentId: UUID(),
                                                                            componentContent: "Dummy Text",
                                                                            componentCategory: "Text",
                                                                            componentRatio: nil,
                                                                            componentScale: nil,
                                                                            componentRotation: nil
                                                                           )
                                                       ], pagePicture: [
                                                        PictureComponentEntity(componentId: UUID(),
                                                                               componentContent: "DummyImage",
                                                                               componentCategory: "AssetPicture",
                                                                               componentRatio: nil,
                                                                               componentScale: nil,
                                                                               componentRotation: nil
                                                                              )
                                                       ], pageVideo: [],
                                                       pageSoundPath: "Sound"
                                                      ),
                                            PageEntity(pageId: UUID(),
                                                       pageText: [
                                                        TextComponentEntity(componentId: UUID(),
                                                                            componentContent: "Dummy Text",
                                                                            componentCategory: "Text",
                                                                            componentRatio: nil,
                                                                            componentScale: nil,
                                                                            componentRotation: nil
                                                                           )
                                                       ], pagePicture: [
                                                        PictureComponentEntity(componentId: UUID(),
                                                                               componentContent: "DummyImage",
                                                                               componentCategory: "AssetPicture",
                                                                               componentRatio: nil,
                                                                               componentScale: nil,
                                                                               componentRotation: nil
                                                                              )
                                                       ], pageVideo: [],
                                                       pageSoundPath: "Sound"
                                                      ),
                                            PageEntity(pageId: UUID(),
                                                       pageText: [
                                                        TextComponentEntity(componentId: UUID(),
                                                                            componentContent: "Dummy Text",
                                                                            componentCategory: "Text",
                                                                            componentRatio: nil,
                                                                            componentScale: nil,
                                                                            componentRotation: nil
                                                                           )
                                                       ], pagePicture: [
                                                        PictureComponentEntity(componentId: UUID(),
                                                                               componentContent: "DummyImage",
                                                                               componentCategory: "AssetPicture",
                                                                               componentRatio: nil,
                                                                               componentScale: nil,
                                                                               componentRotation: nil
                                                                              )
                                                       ], pageVideo: [],
                                                       pageSoundPath: "Sound"
                                                      )
                                         ]))
}
