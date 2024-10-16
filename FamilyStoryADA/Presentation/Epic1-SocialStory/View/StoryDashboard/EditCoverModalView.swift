//
//  EditCoverModalView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 16/10/24.
//

import SwiftUI

struct EditCoverModalView: View {
    @Binding var storyTitle: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
                    // Close button
                    HStack {
                        Spacer()
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                    
                    // Title
                    Text("Edit Cover")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // Text field for story title
                    TextField("Judul Story", text: $storyTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    // Display images as a grid
                    ScrollView {
                        VStack(spacing: 10) {
                            Image("image1") // Replace with your images
                                .resizable()
                                .scaledToFit()
                                .frame(height: 120)
                            
                            HStack(spacing: 10) {
                                Image("image2") // Replace with your images
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 80)
                                
                                Image("image3") // Replace with your images
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 80)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Done button
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
                .padding()
    }
}

#Preview {
    EditCoverModalView(storyTitle: .constant("Cara menyikat gigi"))
}
