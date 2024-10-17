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
    
    init(story: StoryEntity) {
        _viewModel = StateObject(wrappedValue: PageCustomizationViewModel(story: story))
    }
    
    var body: some View {
        //TODO: change to real data
        HStack {
            VStack(spacing: 32) {
                Button(action: {
                    dismiss()
                }, label: {
                    CustomizedBackButton()
                })
                DraggablePageCustomizationSelectionView(viewModel: viewModel, draggedPages: $viewModel.draggedPages)
            }
            
            ZStack {
                Image("CustomizationBackground")
            }
        }
        .padding(.top, 26)
        .ignoresSafeArea()
        .background(Color("FSBlue6"))
        .navigationBarBackButtonHidden()
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
