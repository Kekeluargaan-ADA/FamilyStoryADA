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
    @StateObject private var networkMonitor = NetworkMonitor()
    
    @State var isParaphrasingPresented = false
    @State var currentText: String = ""
    @State private var isLimitReached = false
    
    @StateObject private var keyboardHelper = KeyboardHelper()
    
    init(story: StoryEntity) {
        _viewModel = StateObject(wrappedValue: PageCustomizationViewModel(story: story))
    }
    
    var body: some View {
        NavigationView {
            GeometryReader{ geometry in
                let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
                let heightRatio = ratios.heightRatio
                let widthRatio = ratios.widthRatio
                ZStack (alignment: .center){
                    HStack(alignment: .top) {
                        VStack(spacing: 32 * heightRatio) {
                            Button(action: {
                                viewModel.updatePage()
                                dismiss()
                            }, label: {
                                CustomizedBackButton(widthRatio: widthRatio, heightRatio: heightRatio)
                            })
                            //                            DraggablePageCustomizationSelectionView(draggedPages: $viewModel.draggedPages)
                            //                                .disabled(keyboardHelper.isKeyboardShown)
                            ZStack(alignment: .top) {
                                DraggablePageReorderedCustomizationView(draggedPages: $viewModel.draggedPages, introPages: $viewModel.introPages, isVideoReadyToPlay: $viewModel.isVideoReadyToPlay, widthRatio: widthRatio, heightRatio: heightRatio)
                                    .disabled(keyboardHelper.isKeyboardShown || isParaphrasingPresented)
                                
                                Rectangle()
                                    .foregroundStyle(.clear)
                                    .frame(width: 170 * widthRatio, height: 840 * heightRatio)
                                    .highlight(
                                        order: 2,
                                        title: "Edit Halaman",
                                        description: "Tahan dan geser halaman untuk mengganti sequence.",
                                        cornerRadius: 8 * heightRatio,
                                        style: .continuous,
                                        position: .centerTrailing
                                    )
                                    .offset(y: -10 * heightRatio)
                                Rectangle()
                                    .foregroundStyle(.clear)
                                    .frame(width: 170 * widthRatio, height: 840 * heightRatio)
                                    .highlight(
                                        order: 1,
                                        title: "Lihat Semua Halaman",
                                        description: "Scroll dan lihat keseluruhan halaman. Tekan 􀏇 untuk menambahkan halaman baru.",
                                        cornerRadius: 8 * heightRatio,
                                        style: .continuous,
                                        position: .centerTrailing
                                    )
                                    .offset(y: -10 * heightRatio)
                            }
                        }
                        
                        
                        ZStack {
                            ZStack(alignment: .top) {
                                Image("create-story-background")
                                    .resizable()
                                    .frame(width: 1000 * widthRatio, height: 854 * heightRatio)
//                                    .ignoresSafeArea()
                                ZStack (alignment: .center) {
                                    RoundedRectangle(cornerRadius: 28 * heightRatio)
                                        .fill(Color("FSYellow"))
                                    Text(viewModel.story.storyName)
                                        .font(Font.custom("Fredoka", size: 24 * heightRatio, relativeTo: .title2))
                                        .fontWeight(.medium)
                                        .foregroundStyle(Color("FSBlack"))
                                }
                                .frame(width: 268 * widthRatio, height: 45 * heightRatio)
                                .offset(y: 5 * heightRatio)
                                VStack(spacing: 23 * heightRatio) {
                                    CustomizationHeaderView(
                                        story: viewModel.story,
                                        selectedPage: viewModel.selectedPage,
                                        isMiniQuizPresented: $viewModel.isMiniQuizOpened,
                                        isDeleteSelected: $viewModel.isDeleteSelected,
                                        widthRatio: widthRatio,
                                        heightRatio: heightRatio,
                                        deletePage: {
                                            viewModel.deletePage()
                                        }
                                    )
                                    .padding(.top, 20 * heightRatio)
                                    .padding(.horizontal, 46 * widthRatio)
                                    
                                    CustomizationContentView(viewModel: viewModel, currentText: currentText, isParaphrasingPresented: $isParaphrasingPresented, isLimitReached: isLimitReached, widthRatio: widthRatio, heightRatio: heightRatio)
                                        .environmentObject(keyboardHelper)
                                        .environmentObject(cameraViewModel)
                                }
                            }
                        }
                        .onTapGesture {
                            if keyboardHelper.isKeyboardShown || isParaphrasingPresented {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                keyboardHelper.isKeyboardShown = false
                                isParaphrasingPresented = false
                            }
                        }
                        
                        NavigationLink(isActive: $viewModel.isMiniQuizOpened, destination: {
                            MiniGameView(story: viewModel.story)
                        }, label: {})
                        
                        NavigationLink(isActive: $cameraViewModel.navigateToCamera, destination: {
                            CameraView.shared
                                .environmentObject(cameraViewModel)
                        }, label: {})
                        .onChange(of: cameraViewModel.navigateToCamera) { _, value in
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
                        .onChange(of: cameraViewModel.savedImage) { _, value in
                            
                            if !cameraViewModel.isPhotoCaptured, let imageFileName = cameraViewModel.saveImage(), let currentPage = viewModel.selectedPage {
                                if currentPage.pagePicture.isEmpty {
                                    viewModel.selectedPage?.pagePicture.append(PictureComponentEntity(componentId: UUID(), componentContent: imageFileName, componentCategory: "AppStoragePicture"))
                                } else {
                                    viewModel.selectedPage?.pagePicture.first?.componentContent = imageFileName
                                    viewModel.selectedPage?.pagePicture.first?.componentCategory = "AppStoragePicture"
                                }
                                viewModel.updatePage()
                                cameraViewModel.savedImage = nil
                                viewModel.isMediaOverlayOpened = false
                            }
                        }
                    }
                    .sheet(isPresented: $cameraViewModel.showingImagePicker, onDismiss: {
                        if cameraViewModel.isPhotoCaptured, let _ = cameraViewModel.savedImage {
                            // Show crop view once an image is selected
                            cameraViewModel.showCropView = true
                        }
                    }) {
                        ImagePicker()
                            .environmentObject(cameraViewModel)
                    }
                    .padding(.top, 26 * heightRatio)
                    .ignoresSafeArea()
                    .background(Color("FSBlue6"))
                    .environmentObject(viewModel)
                    .onChange(of: viewModel.selectedPage) { _, newSelectedPage in
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
                                VStack {
                                    UploadPhotoModalView(widthRatio: widthRatio, heightRatio: heightRatio)
                                    Spacer().frame(height: 241 * heightRatio)
                                }
                            }
                            .ignoresSafeArea()
                            .environmentObject(viewModel)
                            .environmentObject(cameraViewModel)
                        }
                    }
                    if viewModel.isGotoScrapImage {
                        ScrappingInitialView(widthRatio: widthRatio, heightRatio: heightRatio)
                            .background(.black.opacity(0.4))
                            .environmentObject(viewModel)
                            .environmentObject(cameraViewModel)
                            .environmentObject(networkMonitor)
                        
                    }
                    
                    if isParaphrasingPresented{
                        ZStack{
                            ParaphraseModal(viewModel: viewModel, isParaphrasingPresented: $isParaphrasingPresented, widthRatio: widthRatio, heightRatio: heightRatio)
                                .frame(width: 1200 * widthRatio, height: 450 * heightRatio)
                                .cornerRadius(32 * heightRatio)
                                .background(.white)
                        }.frame(height: 900 * heightRatio, alignment: .bottom)
                        
                    }
                    
                }
                
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden()
        .onChange(of: viewModel.isGotoScrapImage) { _, value in
            if !value, cameraViewModel.isPhotoCaptured, cameraViewModel.savedImage != nil {
                cameraViewModel.showCropView = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("RestartTutorial"))) { _ in
            UserDefaults.standard.set(true, forKey: "customizationTutorial")
            UserDefaults.standard.synchronize()
        }
        .modifier(HighlightRoot(showHighlights: UserDefaults.standard.bool(forKey: "customizationTutorial"), onFinished: {
            UserDefaults.standard.set(false, forKey: "customizationTutorial")
            UserDefaults.standard.synchronize()
        }))
    }
    
}

#Preview {
    CustomizationView(story: StoryEntity(storyId: UUID(),
                                         storyName: "ABC",
                                         storyCoverImagePath: "DummyImage",
                                         storyLastRead: Date(),
                                         templateId: UUID(),
                                         templateCategory: "Hygiene",
                                         isStoryGameable: true,
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
                                         ],
                                         storyResultImagePath: "ss01-finish-image"))
}
