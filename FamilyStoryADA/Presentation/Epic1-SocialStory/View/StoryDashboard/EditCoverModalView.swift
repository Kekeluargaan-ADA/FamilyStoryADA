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
    
    var body: some View {
        VStack(spacing: 20) {
            HStack() {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    ButtonCircle(heightRatio: 1.0, buttonImage: "xmark", buttonColor: .blue)
                })
                
                Spacer()
                
                Text("Edit Cover")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                Spacer()
                
                Button(action: {
                    story.storyName = storyName
                    story.storyCoverImagePath = imagePath
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    ButtonCircle(heightRatio: 1.0, buttonImage: "checkmark", buttonColor: .blue)
                })
                
            }
            
            ZStack() {
                TextField("Judul Story...", text: $storyName)
                    .background(Color("FSWhite"))
                    .multilineTextAlignment(.center)
                    .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
                    .fontWeight(.medium)
                    .frame(width: 580, height: 80)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                HStack {
                    Spacer()
                    Button(action: {
                        storyName = ""
                    }, label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .frame(width: 29, height: 29)
                            .foregroundStyle(Color("FSGrey"))
                    })
                }
                .padding(.horizontal, 60)
            }
            
            
            
            VStack(spacing: 28) {
                Image(imagePath)
                    .resizable()
                    .frame(width: 400, height: 248)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(imageOptionPath, id: \.self) { imageOption in
                            Button(action:{
                                imagePath = imageOption
                            }, label: {
                                ZStack {
                                    Image(imageOption)
                                        .resizable()
                                        .frame(width: 200, height: 124)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                    if imagePath == imageOption {
                                        RoundedRectangle(cornerRadius: 12)
                                            .strokeBorder(Color("FSBlue9"), lineWidth: 3)
                                            .foregroundStyle(Color.clear)
                                            .frame(width: 200, height: 124)
                                            
                                    }
                                }
                            })
                        }
                    }
                    .padding(28)
                }
                .background(Color("FSWhite").shadow(.drop(radius: 4, x: 0, y: 4)))
                .frame(width: 580, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 12))
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
