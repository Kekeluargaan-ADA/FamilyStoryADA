//
//  LibraryPreviewModality.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 14/10/24.
//

import SwiftUI

struct PagePreviewModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: TemplateViewModel
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
            ZStack {
                VStack {
                    if viewModel.isImageInputModalPresented == false, let template = viewModel.selectedTemplate {
                        HStack {
                            ZStack {
                                HStack {
                                    Button(action: {
                                        viewModel.isPagePreviewModalPresented.toggle()
                                        viewModel.isImageInputModalPresented = false
                                        //presentationMode.wrappedValue.dismiss()
                                    }) {
                                        ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "xmark", buttonColor: .blue) // Use fixed height for button
                                    }
                                    Spacer()
                                }
                                Text(template.templateName)
                                    .font(
                                        Font.custom("Fredoka", size: 32 * heightRatio)
                                            .weight(.semibold)
                                    )
                                    .foregroundColor(Color("FSBlack"))
                            }
                        }
                        .padding(.horizontal, 24 * widthRatio)
                        .padding(.top, 24 * heightRatio)
                    }
                    //                            Spacer().frame(height: 24)
                    
                    BriefSquareView(heightRatio: heightRatio, widthRatio: widthRatio)
                        .environmentObject(viewModel)
                    //                            Spacer().frame(height: 24)
                    ScrollView {
                        LazyVGrid(
                            columns: [GridItem(.flexible(), spacing: 20 * heightRatio), GridItem(.flexible(), spacing: 20 * heightRatio)],
                            spacing: 8 * widthRatio
                        ) {
                            ForEach(Array(viewModel.getDisplayedPreview().enumerated()), id: \.offset) { index, value in
                                StepsSquareView(heightRatio: heightRatio, widthRatio: widthRatio, order: index + 1, text: value.templateText, imageAssetName: value.templateImage)
                                }
                        }
                    }
                    .frame(width: 580 * widthRatio)
//                    .padding(.horizontal, 45)
                }
//                .padding(24)
                .frame(width: 728 * widthRatio, height: 743 * heightRatio)
                .background(Color("FSBlue1"))
                .cornerRadius(20)
                .padding()
                
            }
            .frame(width: 1194 * widthRatio, height: 834 * heightRatio)
            .background(.black.opacity(0.4))
    }
}
