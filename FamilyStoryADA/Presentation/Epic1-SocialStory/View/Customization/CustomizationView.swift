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
    @StateObject var cameraViewModel: CameraViewModel = CameraViewModel()
    
    @State var currentText: String = ""
    @State private var typingTimer: Timer? = nil
    
    init(story: StoryEntity) {
        _viewModel = StateObject(wrappedValue: PageCustomizationViewModel(story: story))
    }
    
    var body: some View {
        NavigationView {
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
                                .font(Font.custom("Fredoka", size: 24, relativeTo: .title2))
                                .fontWeight(.medium)
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
                                }
                            }
                            .padding(.top, 20)
                            .padding(.horizontal, 46)
                            
                            if let page = viewModel.selectedPage {
                                VStack(alignment: .center, spacing: 19) {
                                    if page.pagePicture.first?.componentCategory == "AssetPicture", let imagePath = page.pagePicture.first?.componentContent {
                                        
                                        ZStack(alignment: .topTrailing) {
                                            Image(imagePath)
                                                .resizable()
                                                .frame(width: 760, height: 468)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                            
                                            Menu {
                                                Button(action: {
                                                    viewModel.isGotoCameraView = true
                                                }) {
                                                    Label("Take Photo", systemImage: "camera")
                                                }
                                                
                                                Button(action: {
                                                    viewModel.isGotoImagePicker = true
                                                }) {
                                                    Label("Choose Photo", systemImage: "photo")
                                                }
                                                
                                                Button(action: {
                                                    // TODO: Generate photo view
                                                    viewModel.isGotoScrapImage = true
                                                }) {
                                                    Label("Generate Photo", systemImage: "photo.on.rectangle.angled")
                                                }
                                            } label: {
                                                Image(systemName: "ellipsis")
                                                    .font(.system(size: 26))
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(Color("FSWhite"))
                                                    .padding()
                                            }
                                        }
                                    } else if page.pagePicture.first?.componentCategory == "AppStoragePicture", let imagePath = page.pagePicture.first?.componentContent, let image = viewModel.loadImageFromDiskWith(fileName: imagePath) {
                                        ZStack(alignment: .topTrailing) {
                                            Image(uiImage: image)
                                                .resizable()
                                                .frame(width: 760, height: 468)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                            
                                            Menu {
                                                Button(action: {
                                                    viewModel.isGotoCameraView = true
                                                }) {
                                                    Label("Take Photo", systemImage: "camera")
                                                }
                                                
                                                Button(action: {
                                                    viewModel.isGotoImagePicker = true
                                                }) {
                                                    Label("Choose Photo", systemImage: "photo")
                                                }
                                                
                                                Button(action: {
                                                    // TODO: Generate photo view
                                                    viewModel.isGotoScrapImage = true
                                                }) {
                                                    Label("Generate Photo", systemImage: "photo.on.rectangle.angled")
                                                }
                                            } label: {
                                                Image(systemName: "ellipsis")
                                                    .font(.system(size: 26))
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(Color("FSWhite"))
                                                    .padding()
                                            }
                                        }
                                        
                                    } else if !page.pageVideo.isEmpty, let videoComponent = page.pageVideo.first, let url = Bundle.main.url(forResource: videoComponent.componentContent, withExtension: "mp4") {
                                        
                                        let videoPlayer = AVPlayer(url: url)
                                        ZStack(alignment: .topTrailing){
                                            VideoPlayer(player: videoPlayer)
                                                .frame(width: 760, height: 468)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .onAppear() {
                                                    videoPlayer.play()
                                                }
                                                .onDisappear() {
                                                    videoPlayer.pause()
                                                }
                                            
                                            Menu {
                                                Button(action: {
                                                    viewModel.isGotoCameraView = true
                                                }) {
                                                    Label("Take Photo", systemImage: "camera")
                                                }
                                                
                                                Button(action: {
                                                    viewModel.isGotoImagePicker = true
                                                }) {
                                                    Label("Choose Photo", systemImage: "photo")
                                                }
                                                
                                                Button(action: {
                                                    // TODO: Generate photo view
                                                    viewModel.isGotoScrapImage = true
                                                }) {
                                                    Label("Generate Photo", systemImage: "photo.on.rectangle.angled")
                                                }
                                            } label: {
                                                Image(systemName: "ellipsis")
                                                    .font(.system(size: 26))
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(Color("FSWhite"))
                                                    .padding()
                                            }
                                        }
                                        
                                    } else {
                                        Button(action: {
                                            // TODO: Pop up menu
                                            viewModel.isMediaOverlayOpened = true
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
                                    .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
                                    .fontWeight(.semibold)
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
                NavigationLink(isActive: $viewModel.isMiniQuizOpened, destination: {
                    MiniQuizView(story: viewModel.story)
                }, label: {})
            }
            .padding(.top, 26)
            .ignoresSafeArea()
            .background(Color("FSBlue6"))
            .environmentObject(viewModel)
            .onChange(of: viewModel.selectedPage) { newSelectedPage in
                if let newPage = newSelectedPage {
                    currentText = newPage.pageText.first?.componentContent ?? ""
                } else {
                    currentText = ""
                }
            }
            .overlay {
                if viewModel.isMediaOverlayOpened {
                    ZStack {
                        Color("FSBlack").opacity(0.4)
                        UploadPhotoModalView()
                    }
                    .ignoresSafeArea()
                    .environmentObject(viewModel)
                }
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden()
        
        NavigationLink(isActive: $viewModel.isGotoCameraView, destination: {
            CameraView()
                .environmentObject(cameraViewModel)
        }, label: {})
        .onChange(of: cameraViewModel.savedImageFilename) { value in
            guard value != nil else { return }
            if let page = viewModel.selectedPage, page.pagePicture.isEmpty, let fileName = value {
                viewModel.isGotoCameraView = false
                viewModel.selectedPage?.pagePicture.append(PictureComponentEntity(componentId: UUID(),
                                                                                  componentContent: fileName,
                                                                                  componentCategory: "AppStoragePicture")
                )
            } else if let fileName = value {
                viewModel.selectedPage?.pagePicture.first?.componentContent = fileName
                viewModel.selectedPage?.pagePicture.first?.componentCategory = "AppStoragePicture"
            }
            viewModel.updatePage()
            viewModel.isGotoCameraView = false
            cameraViewModel.savedImageFilename = nil
            cameraViewModel.capturedImage = nil
        }
        
        NavigationLink(isActive: $viewModel.isGotoImagePicker, destination: {
            ImagePicker(selectedImage: $cameraViewModel.savedImage)
        }, label: {})
        .onChange(of: cameraViewModel.savedImage ?? UIImage()) { value in
            if let page = viewModel.selectedPage, page.pagePicture.isEmpty {
                viewModel.isGotoImagePicker = false
                let fileName = CameraDelegate.saveImageToAppStorage(value)
                viewModel.selectedPage?.pagePicture.append(PictureComponentEntity(componentId: UUID(),
                                                                                  componentContent: fileName,
                                                                                  componentCategory: "AppStoragePicture")
                )
            } else {
                let fileName = CameraDelegate.saveImageToAppStorage(value)
                viewModel.selectedPage?.pagePicture.first?.componentContent = fileName
                viewModel.selectedPage?.pagePicture.first?.componentCategory = "AppStoragePicture"
            }
            viewModel.updatePage()
            viewModel.isGotoImagePicker = false
        }
        
        NavigationLink(isActive: $viewModel.isGotoScrapImage, destination: {
            ScrappingInitialView()
        }, label: {})
    }
    
    private func resetTypingTimer() {
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
