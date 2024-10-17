//
//  CustomizationView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import SwiftUI

struct CustomizationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: PageCustomizationViewModel
    
    @State var currentText: String = ""
    
    init(story: StoryEntity) {
        _viewModel = StateObject(wrappedValue: PageCustomizationViewModel(story: story))
    }
    
    var body: some View {
        HStack {
            VStack(spacing: 32) {
                Button(action: {
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
                    }
                    .frame(width: 268, height: 45)
                    VStack(spacing: 48) {
                        HStack {
                            Button(action: {
                                viewModel.deletePage()
                            }, label: {
                                ButtonCircle(heightRatio: 1.0, buttonImage: "trash")
                            })
                            
                            Spacer()
                            //TODO: Disable when page is null
                            HStack (spacing: 12) {
                                Button(action: {
                                    // TODO: Navigate to play story view
                                }, label: {
                                    ButtonCircle(heightRatio: 1.0, buttonImage: "play")
                                })
                                
                                Button(action: {
                                    // TODO: Navigate to quiz view
                                }, label: {
                                    ButtonCircle(heightRatio: 1.0, buttonImage: "gamecontroller")
                                })
                                
                            }
                        }
                        .padding(.top, 20)
                        .padding(.horizontal, 46)
                        
                        if (viewModel.selectedPage != nil) {
                            VStack(alignment: .center, spacing: 19) {
                                Button(action: {
                                    
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color("FSWhite"))
                                            .strokeBorder(Color("FSBorderBlue7"), lineWidth: 2)
                                            .shadow(radius: 4, x: 0, y: 4)
                                        VStack(spacing: 8) {
                                            Image(systemName: "photo")
                                                .font(.system(size: 36))
                                                .foregroundStyle(Color("FSBlue9"))
                                            Text("Upload Photo")
                                                .font(.system(size: 24, weight: .medium))
                                                .foregroundStyle(Color("FSBlue9"))
                                        }
                                    }
                                    .frame(width: 760, height: 468)
                                })
                                
                                TextField("Masukkan teks di sini", text: $currentText)
                                    .padding(.horizontal, 19)
                                    .padding(.vertical, 15)
                                    .frame(width: 760, height: 117)
                                    .font(.system(size: 32, weight: .semibold))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color("FSBorderBlue7"), lineWidth: 2)
                                    )
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
                                                                            componentRatio: nil,
                                                                            componentScale: nil,
                                                                            componentRotation: nil
                                                                           )
                                                       ], pagePicture: [
                                                        PictureComponentEntity(componentId: UUID(),
                                                                               componentContent: "DummyImage",
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
                                                                            componentRatio: nil,
                                                                            componentScale: nil,
                                                                            componentRotation: nil
                                                                           )
                                                       ], pagePicture: [
                                                        PictureComponentEntity(componentId: UUID(),
                                                                               componentContent: "DummyImage",
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
                                                                            componentRatio: nil,
                                                                            componentScale: nil,
                                                                            componentRotation: nil
                                                                           )
                                                       ], pagePicture: [
                                                        PictureComponentEntity(componentId: UUID(),
                                                                               componentContent: "DummyImage",
                                                                               componentRatio: nil,
                                                                               componentScale: nil,
                                                                               componentRotation: nil
                                                                              )
                                                       ], pageVideo: [],
                                                       pageSoundPath: "Sound"
                                                      )
                                         ]))
}
