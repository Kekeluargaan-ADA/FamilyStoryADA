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
                HStack(spacing: 20 * widthRatio) {
                    Image(template.templateCoverImagePath)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 280 * widthRatio, height: 172 * heightRatio)
                        .cornerRadius(12 * heightRatio)
                    VStack {
                        Text(template.templateDescription)
                            .font(
                                Font.custom("Fredoka", size: 16 * heightRatio)
                                    .weight(.medium)
                            )
                            .foregroundColor(.black)
                            .frame(width: 228 * widthRatio, height: 160 * heightRatio, alignment: .trailing)
                            .multilineTextAlignment(.leading)
                        
                        Button(action: {
                            viewModel.isImageInputModalPresented.toggle()
                        }) {
                            Text("Gunakan template")
                                .font(
                                    Font.custom("Fredoka", size: 20 * heightRatio)
                                        .weight(.medium)
                                )
                                .foregroundStyle(.white)
                                .frame(width: 224 * widthRatio, height: 40 * heightRatio)
                                .background((Color("FSBlue9")))
                                .cornerRadius(20 * heightRatio)
                        }
                        
                        // Change logic, requested by designer
//                        .simultaneousGesture(TapGesture().onEnded {
//                            if let id = viewModel.addNewStory(templateId: template.templateId) {
//                                viewModel.createdStory = viewModel.fetchStoryById(storyId: id)
//                            }
//                            
//                        })
                    }
                    .frame(width: 224 * widthRatio, height: 160 * heightRatio, alignment: .bottom)
                }
                .frame(width: 580 * widthRatio, height: 228 * heightRatio)
                .background(.white)
                .cornerRadius(20 * heightRatio)
                
                if viewModel.isImageInputModalPresented{
                    ImageInputModal(widthRatio: widthRatio, heightRatio: heightRatio)
                        .frame(height: 743 * heightRatio, alignment: .center)
                }
                
            }
        }
        
    }
}

//#Preview {
//    BriefSquareView(heightRatio: 1, widthRatio: 1)
//}
