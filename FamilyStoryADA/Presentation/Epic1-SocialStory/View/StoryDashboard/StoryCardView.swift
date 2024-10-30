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
                .foregroundStyle(Color("FSWhite").shadow(.drop(radius: 4, x: 0, y: 4)))
            VStack(alignment: .leading, spacing: 6) {
                Image(imagePath)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 354, height: 220)
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(category)
                            .font(Font.custom("Fredoka", size: 16, relativeTo: .callout))
                            .foregroundStyle(Color("FSBlack"))
                        Spacer()
                        Text("\(storyLength, specifier: "%.1f") min")
                            .font(Font.custom("Fredoka", size: 14, relativeTo: .footnote))
                            .foregroundStyle(Color("FSGrey"))
                    }
                    Text(storyName)
                        .font(Font.custom("Fredoka", size: 24, relativeTo: .title2))
                        .fontWeight(.semibold)
                    
//                    Text("Terakhir dilihat \(lastRead.formatted(date: .abbreviated, time: .omitted))")
                    Text("Terakhir dilihat \(lastRead.formatted(.dateTime.day().month()))")
                        .font(Font.custom("Fredoka", size: 14, relativeTo: .footnote))
                        .foregroundStyle(Color("FSBlue9"))
                        .italic()
                }
                .padding(.horizontal, 12)
                Spacer()
            }
            .frame(width: 354, height: 320)
            .clipShape(RoundedRectangle(cornerRadius: 16))
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
