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
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .padding()
                }
                Spacer()
                
                Text("Edit Cover")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                
                Button(action: {
                    story.storyName = storyName
                    story.storyCoverImagePath = imagePath
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                }
                .padding()
            }
            
            TextField("Judul Story", text: $storyName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            VStack(spacing: 28) {
                Image(imagePath)
                    .resizable()
                    .frame(width: 400, height: 248)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(imageOptionPath, id: \.self) { imageOption in
                            Button(action:{
                                imagePath = imageOption
                            }, label: {
                                Image(imageOption)
                                    .resizable()
                                    .frame(width: 200, height: 124)
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .border(imagePath == imageOption ? Color.blue : Color.clear, width: 2)
                            })
                        }
                    }
                }
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
