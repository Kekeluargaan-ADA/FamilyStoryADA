//
//  StoryCardView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import SwiftUI

struct StoryCardView: View {
    
    var viewModel: StoryViewModel
    var storyName: String
    var imagePath: String
    var category: String
    var storyLength: Double
    var lastRead: Date
    var story: StoryEntity
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 354, height: 320)
                .foregroundStyle(.white)
                .shadow(radius: 4, x: 0, y: 4)
            VStack(alignment: .leading, spacing: 6) {
                Image(imagePath)
                    .resizable()
                    .frame(width: 354, height: 220)
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(category)
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
                    viewModel.currentlyEditedStory = story
                    viewModel.isEditCoverSheetOpened.toggle()
                }) {
                    Label("Edit Cover", systemImage: "photo")
                }
                
                Button(action: {
                    viewModel.deleteStory(storyId: story.storyId)
                }) {
                    Label("Hapus Story", systemImage: "trash.fill")
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
