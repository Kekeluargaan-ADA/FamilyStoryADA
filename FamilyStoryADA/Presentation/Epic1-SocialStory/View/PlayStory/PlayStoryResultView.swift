//
//  PlayStoryResultView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 10/10/24.
//

import SwiftUI

struct PlayStoryResultView: View {
    @EnvironmentObject var appRouter: AppRouter
    @Environment(\.dismiss) var dismiss
    var story: StoryEntity
    private let textToSpeechHelper = TextToSpeechHelper()
    
    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            ZStack {
                Image("checkered-background")
                    .resizable()
                    .ignoresSafeArea()
                Image("background-play-story")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    PlayStoryNavigationView(widthRatio: widthRatio,
                                            heightRatio: heightRatio,
                                            title: story.storyName,
                                            buttonColor: .yellow,
                                            onTapHomeButton: {
                        appRouter.popScreen()
                        appRouter.popScreen()
                    }, onTapAudioButton: {textToSpeechHelper.speakIndonesian(story.isStoryGameable ? "Selesai! Apakah kamu ingin bermain susun kartu sekarang?" : "Selesai! Kamu sudah menyelesaikan cerita \(story.storyName)!")}, showAudioButton: true,
                                            titleOverlayReversed: false)
                    .padding(.top, 38 * heightRatio)
                    .padding(.horizontal, 46 * widthRatio)
                    Spacer()
                }
                VStack {
                    Text("Selesai!")
                        .font(Font.custom("Fredoka", size: 64 * heightRatio, relativeTo: .largeTitle))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("FSBlack"))
                        .padding(.bottom, 20 * heightRatio)
                    
                    Image(story.storyResultImagePath)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 600 * widthRatio, height: 371.61 * heightRatio)
                        .padding(.bottom, 25 * heightRatio)
                    
                    if story.isStoryGameable {
                        Text("Apakah kamu ingin bermain susun kartu sekarang?")
                            .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                            .fontWeight(.medium)
                            .foregroundStyle(Color("FSBlack"))
                        
                        HStack (spacing: 20 * widthRatio) {
                            Button(action: {
                                appRouter.popScreenToRoot()
                            }, label: {
                                ButtonElips(text: "Nanti", textSize: 32, buttonPreset: .yellow, buttonStyle: .secondary, widthRatio: widthRatio, heightRatio: heightRatio)
                            })
                            Button(action: {
                                textToSpeechHelper.stopSpeaking()
                                appRouter.popScreenToRoot()
                                appRouter.push(.miniGame(story: story))
                            }, label: {
                                ButtonElips(text: "Main", textSize: 32, buttonPreset: .yellow, buttonStyle: .primary, widthRatio: widthRatio, heightRatio: heightRatio)
                            })
                        }
                    } else {
                        Text("Kamu sudah menyelesaikan cerita \(story.storyName)!")
                            .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                            .fontWeight(.medium)
                            .foregroundStyle(Color("FSBlack"))
                    }
                }
                .padding(.top, 60 * heightRatio)
            }
            
        }
        .background(Color("FSYellow1"))
        .navigationBarBackButtonHidden()
    }
}

