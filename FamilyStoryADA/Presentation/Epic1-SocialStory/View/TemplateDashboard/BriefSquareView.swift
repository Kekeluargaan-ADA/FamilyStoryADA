//
//  BriefSquareView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 20/10/24.
//

import SwiftUI

struct BriefSquareView: View {
    @EnvironmentObject var viewModel: TemplateViewModel
    let heightRatio: CGFloat
    let widthRatio: CGFloat
    
    var body: some View {
        if let template = viewModel.selectedTemplate {
            ZStack{
                HStack(spacing: 20) {
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
                            viewModel.isImageInputModalPresented.toggle()
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
                        
                        // Change logic, requested by designer
//                        .simultaneousGesture(TapGesture().onEnded {
//                            if let id = viewModel.addNewStory(templateId: template.templateId) {
//                                viewModel.createdStory = viewModel.fetchStoryById(storyId: id)
//                            }
//                            
//                        })
                    }
                    .frame(width: 224,height: 160,alignment: .bottom)
                }
                .frame(width: 580,height: 228)
                .background(.white)
                .cornerRadius(20)
                
                if viewModel.isImageInputModalPresented{
                    ImageInputModal()
                        .frame(height: 743,alignment: .center)
                }
                
            }
        }
        
    }
}

//#Preview {
//    BriefSquareView(heightRatio: 1, widthRatio: 1)
//}
