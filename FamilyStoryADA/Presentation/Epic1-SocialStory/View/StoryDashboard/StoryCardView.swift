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
    
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 16 * heightRatio)
                .frame(width: 354 * widthRatio, height: 320 * heightRatio)
                    .foregroundStyle(Color("FSWhite").shadow(.drop(radius: 4 * heightRatio, y: 4 * heightRatio)))
            VStack(alignment: .leading, spacing: 6 * heightRatio) {
                Image(imagePath)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 354 * widthRatio, height: 220 * heightRatio)
                VStack(alignment: .leading, spacing: 6 * heightRatio) {
                    HStack {
                        Text(category)
                            .font(Font.custom("Fredoka", size: 16 * heightRatio, relativeTo: .callout))
                            .foregroundStyle(Color("FSBlack"))
                        Spacer()
                        Text("\(storyLength, specifier: "%.1f") m")
                            .font(Font.custom("Fredoka", size: 14 * heightRatio, relativeTo: .footnote))
                            .foregroundStyle(Color("FSGrey"))
                    }
                    Text(storyName)
                        .font(Font.custom("Fredoka", size: 24 * heightRatio, relativeTo: .title2))
                        .fontWeight(.semibold)
                    
//                    Text("Terakhir dilihat \(lastRead.formatted(date: .abbreviated, time: .omitted))")
                    Text("Terakhir dilihat \(lastRead.formatted(.dateTime.day().month()))")
                        .font(Font.custom("Fredoka", size: 14 * heightRatio, relativeTo: .footnote))
                        .foregroundStyle(Color("FSBlue9"))
                        .italic()
                }
                .padding(.horizontal, 12 * widthRatio)
                Spacer()
            }
            .frame(width: 354 * widthRatio, height: 320 * heightRatio)
            .clipShape(RoundedRectangle(cornerRadius: 16 * heightRatio))
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
