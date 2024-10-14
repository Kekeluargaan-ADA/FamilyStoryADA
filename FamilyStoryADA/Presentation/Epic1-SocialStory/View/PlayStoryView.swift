//
//  PlayStoryView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 10/10/24.
//

import SwiftUI

struct PlayStoryView: View {
    var story: StoryEntity
    @State private var currentPageIndex: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            VStack {
                Spacer()
                HStack {
                    Circle()
                        .foregroundStyle(.gray)
                        .frame(height: 64 * heightRatio)
                        .overlay(
                            Image(systemName: "house")
                                .font(.system(size: 26 * heightRatio))
                        )
                    Spacer()
                    Text(story.templateCategory) // TODO: change to story title
                        .font(.system(size: 26 * heightRatio))
                        .fontWeight(.medium)
                    Spacer()
                    Circle()
                        .foregroundStyle(.gray)
                        .frame(height: 64 * heightRatio)
                        .overlay(
                            Image(systemName: "speaker.wave.2")
                                .font(.system(size: 26 * heightRatio))
                        )
                }
                Spacer().frame(height: 21 * heightRatio)
                ZStack {
                    Rectangle()
                        .foregroundStyle(.gray)
                        .frame(width: 1055 * widthRatio, height: 519 * heightRatio)
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            if currentPageIndex > 0 {
                                currentPageIndex -= 1
                            }
                        }) {
                            Circle()
                                .foregroundStyle(.black)
                                .frame(height: 64 * heightRatio)
                                .overlay(
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.white)
                                        .font(.system(size: 26 * heightRatio))
                                )
                        }
                        .disabled(currentPageIndex == 0)
                        .padding(.leading, -32 * heightRatio)
                        Spacer()
                        Button(action: {
                            if currentPageIndex < story.pages.count - 1 {
                                currentPageIndex += 1
                            }
                        }) {
                            Circle()
                                .foregroundStyle(.black)
                                .frame(height: 64 * heightRatio)
                                .overlay(
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.white)
                                        .font(.system(size: 26 * heightRatio))
                                )
                        }
                        .disabled(currentPageIndex == story.pages.count - 1)
                        .padding(.trailing, -32 * heightRatio)
                    }
                    .frame(width: 1055 * widthRatio, height: 519 * heightRatio)
                }
                Spacer().frame(height: 55 * heightRatio)
                //TODO: Fix page
//                Text(story.pages[currentPageIndex].pageText.first?.componentContent ?? "No text available")
//                    .font(.system(size: 32 * heightRatio))
//                    .fontWeight(.bold)
                Spacer().frame(height: 55 * heightRatio)
            }
            .padding(47 * heightRatio)
        }
    }
}

//#Preview {
//    PlayStoryView(
//        story: Story(
//            storyId: UUID(),
//            templateId: UUID(),
//            templateCategory: "Hygiene",
//            pages: [
//                Page(
//                    pageId: UUID(),
//                    pageText: [
//                        TextComponent(
//                            componentId: UUID(),
//                            componentContent: "Ambil sikat gigi.",
//                            componentRatio: Ratio(xRatio: 1, yRatio: 1, zRatio: 0),
//                            componentScale: 1,
//                            componentRotation: 0
//                        )
//                    ],
//                    pagePicture: [],
//                    pageVideo: [],
//                    pageSoundPath: ""
//                ),
//                Page(
//                    pageId: UUID(),
//                    pageText: [
//                        TextComponent(
//                            componentId: UUID(),
//                            componentContent: "Basahi sikat gigi dengan air.",
//                            componentRatio: Ratio(xRatio: 1, yRatio: 1, zRatio: 0),
//                            componentScale: 1,
//                            componentRotation: 0
//                        )
//                    ],
//                    pagePicture: [],
//                    pageVideo: [],
//                    pageSoundPath: ""
//                )
//            ]
//        )
//    )
//}
