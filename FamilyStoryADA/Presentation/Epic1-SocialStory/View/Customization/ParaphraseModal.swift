//
//  ParaphraseModal.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 29/10/24.
//

import SwiftUI
import Foundation

struct ParaphraseModal: View {
    @StateObject var viewModel: PageCustomizationViewModel
    @Binding var isParaphrasingPresented: Bool
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            // Content aligned to the top leading
            HStack(alignment: .top, spacing: 16) {
                // Close button (xmark)
                Button(action: {
                    // TODO: Pop up menu
                    isParaphrasingPresented.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .font(Font.system(size: 22))
                        .foregroundColor(Color.gray)
                        .padding()
                })
                
                
                // Title and text items
                VStack(alignment: .leading, spacing: 8) {
                    // Title with icon
                    HStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .font(Font.system(size: 32))
                            .foregroundColor(Color.purple)
                        Text("Parafrase")
                            .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("FSBlack"))
                    }
                    
                    // Paraphrased text items
                    VStack(alignment: .leading, spacing: 4) {
                        
                        
                        
                        ForEach(viewModel.paraphrasedOptions, id: \.self) { paraphrasedText in
                            
                            Button(action: {
                                viewModel.selectedPage?.pageText.first?.componentContent = paraphrasedText
                                isParaphrasingPresented = false
                            }) {
                                Text(paraphrasedText)
                                    .font(Font.custom("Fredoka", size: 24, relativeTo: .title2))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("FSBlack"))
                            }
                            Divider()
                            
                        }
                    }
                    .frame(width: 980)
                    .foregroundColor(.black)
                    HStack(spacing: 16) {
                        // Rephrase Button
                        Button(action: {
                            // Rephrase action
                            Task {
                                do {
                                    let result = try await viewModel.getParaphrasing(for: viewModel.selectedPage!.pageText.first!.componentContent)
//                                                                    currentText = result
                                    isParaphrasingPresented = true
                                } catch {
                                    print("Failed to fetch paraphrasing: \(error.localizedDescription)")
                                    // Handle error here, possibly by setting an error message in viewModel
                                }
                            }
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "arrow.clockwise")
                                    .font(Font.custom("Fredoka", size: 20, relativeTo: .title3))
                                    .fontWeight(.medium)
                                Text("Rephrase")
                                    .font(Font.custom("Fredoka", size: 20, relativeTo: .title3))
                                    .fontWeight(.medium)
                            }
                            .font(.body)
                            .frame(width: 160,height: 60)
                            .background(Color(.fsSecondaryBlue4))
                            .foregroundColor(Color(.fsBlue9))
                            .cornerRadius(20)
                        }
                        
                        // Pilih Button
                        Button(action: {
                            // Select action
                        }) {
                            Text("Pilih")
                                .font(Font.custom("Fredoka", size: 20, relativeTo: .title3))
                                .fontWeight(.medium)
                                .frame(width: 160,height: 60)
                                .background(Color.teal)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                    .frame(width: 980,alignment: .bottomTrailing)
                }
//                .padding(.top, 16)
                
                Spacer()
            }
//            .padding(.leading, 16) // Padding to adjust alignment with background
//            .padding(.top, 16)
        }
        .frame(width: 1180, height: 256,alignment: .leading)
//        .background(.red)
        .cornerRadius(20)
//        .shadow(radius: 5)
        
//        .padding()  Outer padding for spacing from the screen edges
    }
}

//#Preview{
//    ParaphraseModal()
//}
