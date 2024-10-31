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
    
    @State var isParaphrasingPresented = false
    @State var currentText: String = ""
    @State private var typingTimer: Timer? = nil
    
    @StateObject private var keyboardHelper = KeyboardHelper()
    
    init(story: StoryEntity) {
        _viewModel = StateObject(wrappedValue: PageCustomizationViewModel(story: story))
    }
    
    var body: some View {
        NavigationView {
            GeometryReader{ geometry in
                ZStack{
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
                                VStack(spacing: 23) {
                                    HStack {
                                        if viewModel.selectedPage != nil {
                                            Menu {
                                                Button(action: {
                                                    viewModel.deletePage()
                                                }, label: {
                                                    Text("Hapus Halaman")
                                                })
                                            } label: {
                                                ButtonCircle(heightRatio: 1.0,
                                                             buttonImage: "trash",
                                                             buttonColor: viewModel.isDeleteSelected ? .yellow : .blue
                                                )
                                            }
                                            .onAppear {
                                                viewModel.isDeleteSelected = false
                                            }
                                            .onTapGesture {
                                                viewModel.isDeleteSelected.toggle()
                                            }
                                        }
                                        
                                        Spacer()
                                        //TODO: Disable when page is null
                                        HStack (spacing: 12) {
                                            NavigationLink( destination: {
                                                PlayStoryView(story: viewModel.story, isMiniQuizPresented: $viewModel.isMiniQuizOpened)
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
                                    
                                    // TODO: INI PISAH
                                    if let page = viewModel.selectedPage {
                                        VStack(alignment: .center, spacing: 19) {
                                            
                                            
                                            ZStack(alignment: .topTrailing) {
                                                if page.pagePicture.first?.componentCategory == "AssetPicture", let imagePath = page.pagePicture.first?.componentContent {
                                                    
                                                    if (keyboardHelper.isKeyboardShown || isParaphrasingPresented) {
                                                        Image(imagePath)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 760, height: 468)
                                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                                            .mask(Rectangle().padding(.top, 390))
                                                    } else {
                                                        Image(imagePath)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 760, height: 468)
                                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                                    }
                                                    
                                                } else if page.pagePicture.first?.componentCategory == "AppStoragePicture", let imagePath = page.pagePicture.first?.componentContent, let image = viewModel.loadImageFromDiskWith(fileName: imagePath) {
                                                    
                                                    if (keyboardHelper.isKeyboardShown || isParaphrasingPresented) {
                                                        Image(uiImage: image)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 760, height: 468)
                                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                                            .mask(Rectangle().padding(.top, 390))
                                                    } else {
                                                        Image(uiImage: image)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 760, height: 468)
                                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                                    }
                                                    
                                                } else if !page.pageVideo.isEmpty, let videoComponent = page.pageVideo.first, let url = Bundle.main.url(forResource: videoComponent.componentContent, withExtension: "mp4") {
                                                    
                                                    let videoPlayer = AVPlayer(url: url)
                                                    
                                                    if (keyboardHelper.isKeyboardShown || isParaphrasingPresented) {
                                                        CustomVideoPlayerView(player: viewModel.videoPlayer)
                                                            .frame(width: 760, height: 468)
                                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                                            .mask(Rectangle().padding(.top, 390))
                                                            .onAppear() {
                                                                
                                                                viewModel.videoPlayer = AVPlayer(url: url)
                                                                viewModel.videoPlayer.play()
                                                                // Loop video when it reaches the end
                                                                
                                                            }
                                                            .onDisappear() {
                                                                viewModel.videoPlayer.pause()
                                                            }
                                                            .onChange(of: url) {
                                                                viewModel.videoPlayer = AVPlayer(url: url)
                                                                viewModel.videoPlayer.play()
                                                            }
                                                            .onTapGesture() {
                                                                viewModel.videoPlayer.seek(to: .zero)
                                                                viewModel.videoPlayer.play()
                                                            }
                                                    } else {
                                                        CustomVideoPlayerView(player: viewModel.videoPlayer)
                                                            .frame(width: 760, height: 468)
                                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                                            .onAppear() {
                                                                
                                                                viewModel.videoPlayer = AVPlayer(url: url)
                                                                viewModel.videoPlayer.play()
                                                                // Loop video when it reaches the end
                                                                
                                                            }
                                                            .onDisappear() {
                                                                viewModel.videoPlayer.pause()
                                                            }
                                                            .onChange(of: url) {
                                                                viewModel.videoPlayer = AVPlayer(url: url)
                                                                viewModel.videoPlayer.play()
                                                            }
                                                            .onTapGesture() {
                                                                viewModel.videoPlayer.seek(to: .zero)
                                                                viewModel.videoPlayer.play()
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
                                                
                                                Menu {
                                                    Button(action: {
                                                        cameraViewModel.isPhotoCaptured = false
                                                        cameraViewModel.navigateToCamera = true
                                                    }) {
                                                        Label("Take Photo", systemImage: "camera")
                                                    }
                                                    
                                                    Button(action: {
                                                        cameraViewModel.isPhotoCaptured = false
                                                        cameraViewModel.showingImagePicker = true
                                                    }) {
                                                        Label("Choose Photo", systemImage: "photo")
                                                    }
                                                    
                                                    Button(action: {
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
                                            ZStack {
                                                TextField("Masukkan teks di sini", text: Binding(
                                                    get: { currentText },
                                                    set: { newValue in
                                                        // Split the input text into words
                                                        let words = newValue.split(separator: " ")
                                                        
                                                        currentText = newValue
                                                        //                                                        // Check if the word count exceeds 15
                                                        //                                                        if words.count > 15 {
                                                        //                                                            // Limit to the first 15 words and join them back to a string
                                                        //                                                            currentText = words.prefix(15).joined(separator: " ")
                                                        //                                                        } else {
                                                        //                                                            // Update currentText as usual if the word count is within the limit
                                                        //                                                            currentText = newValue
                                                        //                                                        }
                                                        
                                                        // Reset the typing timer
                                                        
                                                        resetTypingTimer()
                                                    }
                                                ))
                                                .padding(.horizontal, 19)
                                                .padding(.vertical, 15)
                                                .frame(width: 760, height: 168)
                                                .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
                                                .fontWeight(.semibold)
                                                .foregroundStyle(Color("FSBlack"))
                                                .overlay(
                                                    TextBoxBackgroundView()
                                                        .stroke(Color("FSPrimaryOrange5"), lineWidth: 2)
                                                )
                                                .overlay(alignment: .topLeading) {
                                                    Text("\(wordCount)/15 words")
                                                        .font(Font.custom("Fredoka", size: 16))
                                                        .foregroundColor(Color("FSGrey"))
                                                        .padding(.horizontal, 20)
                                                        .padding(.top, 8)
                                                }
                                                

                                                .overlay(alignment: .bottomTrailing) {
                                                    Button(action: {
                                                            Task {
                                                                do {
                                                                    let result = try await viewModel.getParaphrasing(for: currentText)
//                                                                    currentText = result
                                                                    isParaphrasingPresented = true
                                                                } catch {
                                                                    print("Failed to fetch paraphrasing: \(error.localizedDescription)")
                                                                    // Handle error here, possibly by setting an error message in viewModel
                                                                }
                                                            }
                                                    },label:{
                                                        HStack(spacing: 8) {
                                                            Image(systemName: "sparkles")
                                                            Text("Optimalkan")
                                                                .font(.system(size: 16))
                                                                .fontWeight(.medium)
                                                        }
                                                        .foregroundStyle(Color(.fsBlue9))
                                                        .padding()
                                                        .background(
                                                            RoundedRectangle(cornerRadius: 40)
                                                                .strokeBorder(Color("FSBorderBlue7"), lineWidth: 2)
                                                                .background(
                                                                    RoundedRectangle(cornerRadius: 40)
                                                                        .fill(Color.white)
                                                                )
                                                        )
                                                        .padding()
                                                    })
                                                }
                                                .onAppear {
                                                    currentText = page.pageText.first?.componentContent ?? ""
                                                }
                                                .onChange(of: page.pageText.first?.componentContent){
                                                    currentText = page.pageText.first?.componentContent ?? ""
                                                }
                                                // Overlay the HStack at the top left
                                                .overlay(alignment: .topLeading) {
                                                    HStack {
                                                        Image(systemName: "exclamationmark.triangle")
                                                            .font(Font.custom("SF Pro", size: 16))
                                                            .foregroundStyle(Color("FSPrimaryOrange5"))
//                                                        Text("Instruksional")
                                                        Text("\(viewModel.selectedPage!.pageTextClassification)")
                                                            .font(Font.custom("SF Pro", size: 16))
                                                            .foregroundStyle(Color("FSPrimaryOrange5"))
                                                    }
                                                    .padding(.top, 8)
                                                    .padding(.leading, 136)
                                                }
                                            }
                                            
                                        }
                                        .offset(y: (keyboardHelper.isKeyboardShown || isParaphrasingPresented) ? -378 : 0)
                                    }
                                }
                            }
                            
                            
                            
                        }
                        
                        NavigationLink(isActive: $viewModel.isMiniQuizOpened, destination: {
                            MiniQuizView(story: viewModel.story)
                        }, label: {})
                        
                        NavigationLink(isActive: $cameraViewModel.navigateToCamera, destination: {
                            CameraView.shared
                                .environmentObject(cameraViewModel)
                        }, label: {})
                        .onChange(of: cameraViewModel.navigateToCamera) { value in
                            if !value, cameraViewModel.isPhotoCaptured, cameraViewModel.savedImage != nil {
                                // Show crop view once an image is selected
                                cameraViewModel.showCropView = true
                            }
                        }
                        
                        NavigationLink(
                            destination:
                                CropImageView(croppingStyle: .landscape)
                                .environmentObject(cameraViewModel),
                            isActive: $cameraViewModel.showCropView,
                            label: {}
                        )
                        .onChange(of: cameraViewModel.savedImage) { value in
                            
                            if !cameraViewModel.isPhotoCaptured, let imageFileName = cameraViewModel.saveImage(), let currentPage = viewModel.selectedPage {
                                if currentPage.pagePicture.isEmpty {
                                    viewModel.selectedPage?.pagePicture.append(PictureComponentEntity(componentId: UUID(), componentContent: imageFileName, componentCategory: "AppStoragePicture"))
                                } else {
                                    viewModel.selectedPage?.pagePicture.first?.componentContent = imageFileName
                                    viewModel.selectedPage?.pagePicture.first?.componentCategory = "AppStoragePicture"
                                }
                                viewModel.updatePage()
                                cameraViewModel.savedImage = nil
                            }
                        }
                    }
                    .sheet(isPresented: $cameraViewModel.showingImagePicker, onDismiss: {
                        if cameraViewModel.isPhotoCaptured, let selectedImage = cameraViewModel.savedImage {
                            // Show crop view once an image is selected
                            cameraViewModel.showCropView = true
                        }
                    }) {
                        ImagePicker()
                            .environmentObject(cameraViewModel)
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
                            .environmentObject(cameraViewModel)
                        }
                    }
                    if viewModel.isGotoScrapImage {
                        ScrappingInitialView()
                            .background(.black.opacity(0.4))
                            .environmentObject(viewModel)
                            .environmentObject(cameraViewModel)
                            
                    }
                    
                    if isParaphrasingPresented{
                        ZStack{
                            ParaphraseModal(viewModel: viewModel, isParaphrasingPresented: $isParaphrasingPresented)
                                .frame(width: 1200,height: 280)
                                .background(.white)
                        }.frame(height: 780,alignment: .bottom)
                        
                    }
                    
                }
                
            }
            
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden()
        .onChange(of: viewModel.isGotoScrapImage) { value in
            if !value, cameraViewModel.isPhotoCaptured, cameraViewModel.savedImage != nil {
                cameraViewModel.showCropView = true
            }
        }
        
    }
    
    private func resetTypingTimer() {
        typingTimer?.invalidate()
        typingTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            Task {
                do {
                    let result = try await viewModel.getTextClassification(for: currentText)
                    // Uncomment to assign the result if needed
                    // currentText = result
                    viewModel.selectedPage?.pageTextClassification = String(result.dropLast())
                } catch {
                    print("Failed to fetch paraphrasing: \(error.localizedDescription)")
                    // Handle error here, possibly by setting an error message in viewModel
                }
                updatePageText() // Call this after the async operation if order matters
            }
        }
    }

    
    private var wordCount: Int {
        currentText.split(separator: " ").count
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
                                                       pageType: "Opening",
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
                                                       pageSoundPath: "Sound", pageTextClassification: ""
                                                      ),
                                            PageEntity(pageId: UUID(),
                                                       pageType: "Instruction",
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
                                                       pageSoundPath: "Sound", pageTextClassification: ""
                                                      ),
                                            PageEntity(pageId: UUID(),
                                                       pageType: "Instruction",
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
                                                       pageSoundPath: "Sound", pageTextClassification: ""
                                                      )
                                         ]))
}
