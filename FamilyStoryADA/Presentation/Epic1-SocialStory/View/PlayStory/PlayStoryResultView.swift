//
//  PlayStoryResultView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 10/10/24.
//

import SwiftUI

struct PlayStoryResultView: View {
    @EnvironmentObject var playStoryViewModel: PlayStoryViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var isMiniQuizPresented: Bool
    private let textToSpeechHelper = TextToSpeechHelper()
    
    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            ZStack {
                Image("checkered-background")
                    .ignoresSafeArea()
                Image("background-play-story")
                    .ignoresSafeArea()
                VStack {
                    PlayStoryNavigationView(widthRatio: widthRatio, heightRatio: heightRatio, title: playStoryViewModel.story.storyName, buttonColor: .yellow, onTapHomeButton: {
                        playStoryViewModel.isStoryCompleted = true
                    }, onTapAudioButton: {textToSpeechHelper.speakIndonesian(playStoryViewModel.story.isStoryGameable ? "Selesai! Apakah kamu ingin bermain susun kartu sekarang?" : "Selesai! Kamu sudah menyelesaikan cerita \(playStoryViewModel.story.storyName)!")}, showAudioButton: true,
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
                    
                    Image(playStoryViewModel.story.storyResultImagePath)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 600 * widthRatio, height: 371.61 * heightRatio)
                        .padding(.bottom, 25 * heightRatio)
                    
                    if playStoryViewModel.story.isStoryGameable {
                        Text("Apakah kamu ingin bermain susun kartu sekarang?")
                            .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                            .fontWeight(.medium)
                            .foregroundStyle(Color("FSBlack"))
                        
                        HStack (spacing: 20) {
                            Button(action: {
                                playStoryViewModel.isStoryCompleted = true
                            }, label: {
                                ButtonElips(text: "Nanti", buttonPreset: .yellow, buttonStyle: .secondary)
                            })
                            Button(action: {
                                
                                isMiniQuizPresented = true
                                textToSpeechHelper.stopSpeaking()
                            }, label: {
                                ButtonElips(text: "Main", buttonPreset: .yellow, buttonStyle: .primary)
                            })
                        }
                    } else {
                        Text("Kamu sudah menyelesaikan cerita \(playStoryViewModel.story.storyName)!")
                            .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                            .fontWeight(.medium)
                            .foregroundStyle(Color("FSBlack"))
                    }
                }
            }
        }
        .background(Color("FSYellow1"))
        .navigationBarBackButtonHidden()
        .onChange(of: playStoryViewModel.isStoryCompleted) { value in
            if value {
                dismiss()
            }
        }
        .onChange(of: isMiniQuizPresented) { value in
            if !value {
                playStoryViewModel.isStoryCompleted = true
            }
        }
    }
}

