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
    
    var body: some View {
        GeometryReader { geometry in
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
                                        ButtonCircle(widthRatio: 1.0, heightRatio: 1.0, buttonImage: "xmark", buttonColor: .blue) // Use fixed height for button
                                    }
                                    Spacer()
                                }
                                Text(template.templateName)
                                    .font(
                                        Font.custom("Fredoka", size: 32)
                                            .weight(.semibold)
                                    )
                                    .foregroundColor(Color("FSBlack"))
                            }
                        }
                        .padding()
                    }
                    //                            Spacer().frame(height: 24)
                    
                    BriefSquareView(heightRatio: 1.0, widthRatio: 1.0)
                        .environmentObject(viewModel)
                    //                            Spacer().frame(height: 24)
                    ScrollView {
                        LazyVGrid(
                            columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)],
                            spacing: 8
                        ) {
                            ForEach(Array(viewModel.getDisplayedPreview().enumerated()), id: \.offset) { index, value in
                                    StepsSquareView(heightRatio: 1.0, widthRatio: 1.0, order: index + 1, text: value.templateText, imageAssetName: value.templateImage)
                                }
                        }
                    }
                    .frame(width: 580)
//                    .padding(.horizontal, 45)
                }
//                .padding(24)
                .frame(width: 728, height: 743) // Fixed dimensions
                .background(Color("FSBlue1"))
                .cornerRadius(20)
                .padding()
                
            }
            .frame(width: geometry.size.width,height: geometry.size.height)
            .background(.black.opacity(0.4))
        }
    }
}
