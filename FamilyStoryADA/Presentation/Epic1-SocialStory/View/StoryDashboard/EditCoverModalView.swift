//
//  EditCoverModalView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 16/10/24.
//

import SwiftUI
import Combine

struct EditCoverModalView: View {
    @Binding var story: StoryEntity
    var imageOptionPath: [String]
    @Environment(\.presentationMode) var presentationMode
    
    @State var imagePath: String = ""
    @State var storyName: String = ""
    @FocusState private var isTextFieldFocused: Bool
    
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        VStack(spacing: 20 * heightRatio) {
            HStack() {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "xmark", buttonColor: .blue)
                })
                
                Spacer()
                
                Text("Edit Cover")
                    .font(Font.custom("Fredoka", size: 32 * heightRatio))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.fsBlack))
                Spacer()
                
                Button(action: {
                    story.storyName = storyName
                    story.storyCoverImagePath = imagePath
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "checkmark", buttonColor: .blue)
                })
                
            }
            
            ZStack {
                TextField("Judul Story...", text: $storyName)
                    .focused($isTextFieldFocused) // Bind the focus state
                    
                    .multilineTextAlignment(.center)
                    .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                    .fontWeight(.medium)
                    .frame(width: 550 * widthRatio, height: 50 * heightRatio)
                    .background(Color("FSWhite"))
                    .padding(.horizontal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.fsBlue9), lineWidth: 2)
                            .frame(width: 550 * widthRatio, height: 50 * heightRatio)
                    )
                    .animation(.easeInOut, value: isTextFieldFocused)
                if isTextFieldFocused {
                    HStack {
                        Spacer()
                        Button(action: {
                            storyName = ""
                        }, label: {
                            Image(systemName: "x.circle")
                                .font(.system(size: 24 * heightRatio))
                                .fontWeight(.medium)
                                .foregroundStyle(Color("FSGrey"))
                        })
                    }
                    .padding(.horizontal, 50 * widthRatio)
                }
            }
            
            
            
            VStack(spacing: 28 * heightRatio) {
                Image(imagePath)
                    .resizable()
                    .frame(width: 400 * widthRatio, height: 248 * heightRatio)
                    .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .shadow(color: Color(.fsBlack).opacity(0.1), radius: 4, y: 4 * heightRatio)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12 * heightRatio)
                        .fill(Color(.fsWhite).shadow(.drop(color: Color(.fsBlack).opacity(0.1), radius: 4, y: 4 * heightRatio)))
                        .frame(width: 580 * widthRatio, height: 180 * heightRatio)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 20 * widthRatio) {
                            ForEach(imageOptionPath, id: \.self) { imageOption in
                                Button(action:{
                                    imagePath = imageOption
                                }, label: {
                                    ZStack {
                                        Image(imageOption)
                                            .resizable()
                                            .frame(width: 200 * widthRatio, height: 124 * heightRatio)
                                            .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                        if imagePath == imageOption {
                                            RoundedRectangle(cornerRadius: 12 * heightRatio)
                                                .strokeBorder(Color("FSBlue9"), lineWidth: 3 * widthRatio)
                                                .foregroundStyle(Color.clear)
                                                .frame(width: 200 * widthRatio, height: 124 * heightRatio)
                                            
                                        }
                                    }
                                })
                            }
                        }
                        .padding(28 * heightRatio)
                    }
                }
                .frame(width: 580 * widthRatio, height: 180 * heightRatio)
                .padding(.horizontal)
            }
        }
        .onAppear {
            storyName = story.storyName
            imagePath = story.storyCoverImagePath
        }
        .padding()
    }
}

//#Preview {
//    EditCoverModalView(storyTitle: .constant("Cara menyikat gigi"))
//}
