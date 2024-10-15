//
//  StoryCardView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import SwiftUI

struct StoryCardView: View {
    var imagePath: String
    
    // TODO: Change this into story object
    var categoryName: String
    var storyName: String
    // These attributes has not been implemented in the story object
    var lastRead: Date
    var storyLength: Int
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 354, height: 320)
                .foregroundStyle(.white)
            VStack(alignment: .leading, spacing: 6) {
                Image(imagePath)
                    .resizable()
                    .frame(width: 354, height: 220)
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(categoryName)
                            .font(.callout)
                        Spacer()
                        Text("\(storyLength) min")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    Text(storyName)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Terakhir dilihat \(lastRead.formatted(date: .abbreviated, time: .omitted))")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .italic()
                }
                .padding(.horizontal, 12)
                Spacer()
            }
            .frame(width: 354, height: 320)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            Menu {
                Button(action: {
                    // Action for Rename
                }) {
                    Label("Rename", systemImage: "character.cursor.ibeam")
                }
                
                Button(action: {
                    // Action for Ganti Cover
                }) {
                    Label("Ganti Cover", systemImage: "photo")
                }
                
                Button(action: {
                    // Action for Hapus
                }) {
                    Label("Hapus", systemImage: "trash.fill")
                        .foregroundStyle(.red)
                }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.title2)
                    .foregroundStyle(.black)
                    .padding()
            }
        }
    }
}

#Preview {
    StoryCardView(
        imagePath: "DummyImage",
        categoryName: "Hygiene",
        storyName: "Cara gosok gigi",
        lastRead: Date(),
        storyLength: 3
    )
}
