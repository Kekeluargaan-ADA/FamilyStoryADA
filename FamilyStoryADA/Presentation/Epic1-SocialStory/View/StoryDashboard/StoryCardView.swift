//
//  StoryCardView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import SwiftUI

struct StoryCardView: View {
    
    var story: StoryEntity
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 354, height: 320)
                .foregroundStyle(.white)
            VStack(alignment: .leading, spacing: 6) {
                Image(story.storyCoverImagePath)
                    .resizable()
                    .frame(width: 354, height: 220)
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(story.templateCategory)
                            .font(.callout)
                        Spacer()
                        Text("\(story.storyLength) min")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    Text(story.storyName)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Terakhir dilihat \(story.storyLastRead.formatted(date: .abbreviated, time: .omitted))")
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

//#Preview {
//    StoryCardView(
//        imagePath: "DummyImage",
//        categoryName: "Hygiene",
//        storyName: "Cara gosok gigi",
//        lastRead: Date(),
//        storyLength: 3
//    )
//}
