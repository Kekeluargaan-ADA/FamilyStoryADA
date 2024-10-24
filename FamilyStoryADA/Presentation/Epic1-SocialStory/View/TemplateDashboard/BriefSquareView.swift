//
//  BriefSquareView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 20/10/24.
//

import SwiftUI

struct BriefSquareView: View {
    let heightRatio: CGFloat
    let widthRatio: CGFloat
    @Binding var isImageInputModalPresented: Bool
    @Binding var isPagePreviewModalPresented: Bool
    @StateObject private var viewModel = StoryViewModel() // Add the viewModel to handle story logic
    @Binding var template : TemplateEntity
    @State var story: StoryEntity?
    var body: some View {
        ZStack{
            HStack {
                Image(template.templateCoverImagePath)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 280, height: 172)
                    .cornerRadius(12)
                VStack {
                    Text(template.templateDescription)
                        .font(
                            Font.custom("Fredoka", size: 16)
                                .weight(.medium)
                        )
                        .foregroundColor(.black)
                        .frame(width: 228, height: 160 ,alignment: .trailing)
                        .multilineTextAlignment(.leading)
                    
                    Button(action: {
                        isImageInputModalPresented.toggle()
                        print(isImageInputModalPresented)
                    }) {
                        Text("Gunakan template")
                            .font(
                                Font.custom("Fredoka", size: 20)
                                    .weight(.medium)
                            )
                            .foregroundStyle(.white)
                            .frame(width: 224,height: 40)
                            .background((Color("FSBlue9")))
                            .cornerRadius(20)
                    }
                    
                    .simultaneousGesture(TapGesture().onEnded {
                        if let id = viewModel.addNewStory(templateId: template.templateId) {
                            story = viewModel.fetchStoryById(storyId: id)
                        }
                        
                    })
                }
                .frame(width: 224,height: 160,alignment: .bottom)
            }
            .frame(width: 580,height: 228)
            .background(.white)
            .cornerRadius(20)
            
            if isImageInputModalPresented{
                ImageInputModal(isPresented: $isImageInputModalPresented, story: $story)
                    .frame(height: 743,alignment: .center)
            }
            
        }
        
    }
}

//#Preview {
//    BriefSquareView(heightRatio: 1, widthRatio: 1)
//}
