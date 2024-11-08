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
    @State private var isLimitReached = false
    
    @StateObject private var keyboardHelper = KeyboardHelper()
    
    init(story: StoryEntity) {
        _viewModel = StateObject(wrappedValue: PageCustomizationViewModel(story: story))
    }
    
    var body: some View {
        NavigationView {
            GeometryReader{ geometry in
                ZStack{
                    HStack(alignment: .top) {
                        VStack(spacing: 32) {
                            Button(action: {
                                viewModel.updatePage()
                                dismiss()
                            }, label: {
                                CustomizedBackButton()
                            })
//                            DraggablePageCustomizationSelectionView(draggedPages: $viewModel.draggedPages)
//                                .disabled(keyboardHelper.isKeyboardShown)
                            DraggablePageReorderedCustomizationView(draggedPages: $viewModel.draggedPages, introPages: $viewModel.introPages)
                                .disabled(keyboardHelper.isKeyboardShown)
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
                                    CustomizationHeaderView(
                                        story: viewModel.story,
                                        selectedPage: viewModel.selectedPage,
                                        isMiniQuizPresented: $viewModel.isMiniQuizOpened,
                                        isDeleteSelected: $viewModel.isDeleteSelected,
                                        deletePage: {
                                            viewModel.deletePage()
                                        }
                                    )
                                    .padding(.top, 20)
                                    .padding(.horizontal, 46)

                                    CustomizationContentView(viewModel: viewModel, currentText: currentText, isParaphrasingPresented: $isParaphrasingPresented, isLimitReached: isLimitReached)
                                        .environmentObject(keyboardHelper)
                                        .environmentObject(cameraViewModel)
                                }
                            }
                            
                        }
                        .onTapGesture {
                            if keyboardHelper.isKeyboardShown {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                keyboardHelper.isKeyboardShown = false
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
                                viewModel.isMediaOverlayOpened = false
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
                                .frame(width: 1200,height: 450)
                                .cornerRadius(32)
                                .background(.white)
                        }.frame(height: 900,alignment: .bottom)
                        
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
