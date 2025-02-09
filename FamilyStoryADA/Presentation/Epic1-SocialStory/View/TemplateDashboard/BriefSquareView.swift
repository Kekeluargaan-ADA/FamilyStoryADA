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
    let selectedTemplate: TemplateEntity?
    var onPressUseTemplate: (() -> Void)
    @Binding var isImageInputModalPresented: Bool
    
    var body: some View {
        if let template = selectedTemplate {
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
                        
                        Spacer()
                        
                        Button(action: {
                            onPressUseTemplate()
                        }) {
                            Text("Gunakan template")
                                .font(
                                    Font.custom("Fredoka", size: 20 * heightRatio)
                                        .weight(.medium)
                                )
                                .foregroundStyle(Color(.fsWhite))
                                .frame(width: 224 * widthRatio, height: 40 * heightRatio)
                                .background((Color("FSBlue9")))
                                .cornerRadius(20 * heightRatio)
                        }
                    }
                    .frame(width: 224 * widthRatio, height: 172 * heightRatio, alignment: .bottom)
                }
                .frame(width: 580 * widthRatio, height: 228 * heightRatio)
                .background(Color(.fsWhite))
                .cornerRadius(20 * heightRatio)
                
                if isImageInputModalPresented {
                    ImageInputModal(widthRatio: widthRatio, heightRatio: heightRatio)
                        .frame(height: 743 * heightRatio, alignment: .center)
                }
                
            }
        }
        
    }
}

