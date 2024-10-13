//
//  PlayStoryView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 10/10/24.
//

import SwiftUI

struct PlayStoryView: View {
    var story: Story
    var page: Page

    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            VStack {
                Spacer()
                HStack {
                    ZStack {
                        Circle()
                            .foregroundStyle(.gray)
                            .frame(height: 64 * heightRatio)
                        Image(systemName: "house")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 26 * heightRatio)
                    }
                    Spacer()
                    Text(story.templateCategory) // TODO: change to story title
                        .font(.system(size: 26 * heightRatio))
                        .fontWeight(.medium)
                    Spacer()
                    ZStack {
                        Circle()
                            .foregroundStyle(.gray)
                            .frame(height: 64 * heightRatio)
                        Image(systemName: "speaker.wave.2")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 26 * heightRatio)
                    }
                }
                Spacer().frame(height: 21 * heightRatio)
                HStack {
                    Button(action: {
                    }) {
                        Circle()
                    }
                    Rectangle()
                        .foregroundStyle(.gray)
                        .frame(width: 1055 * widthRatio, height: 519 * heightRatio)
                    Button(action: {
                    }) {
                        Circle()
                    }
                }
                Spacer().frame(height: 55 * heightRatio)
                Text(page.pageText.first?.componentContent ?? "No text available")
                    .font(.system(size: 32 * heightRatio))
                    .fontWeight(.bold)
                Spacer().frame(height: 55 * heightRatio)
            }
            .padding(47 * heightRatio)
        }
    }
}

#Preview {
    PlayStoryView(
        story: Story(
            storyId: UUID(),
            templateId: UUID(),
            templateCategory: "Hygiene",
            pages: []
        ),
        page: Page(
            pageId: UUID(),
            pageText: [
                TextComponent(
                    componentId: UUID(),
                    componentContent: "Ambil sikat gigi.",
                    componentRatio: Ratio(xRatio: 1, yRatio: 1, zRatio: 0),
                    componentScale: 1,
                    componentRotation: 0
                )
            ],
            pagePicture: [],
            pageVideo: [],
            pageSoundPath: ""
        )
    )
}
