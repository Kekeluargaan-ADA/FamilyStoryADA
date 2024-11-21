//
//  MiniGameView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 06/11/24.
//

import SwiftUI

struct MiniGameView: View {
    @StateObject var viewModel: MiniGameViewModel
    @Environment(\.dismiss) var dismiss
    private let textToSpeechHelper = TextToSpeechHelper()
    private let instruction = "Tekan kartu sesuai dengan urutan yang benar."
    
    init(story: StoryEntity) {
        _viewModel = StateObject(wrappedValue: MiniGameViewModel(story: story))
    }
    
    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            ZStack {
                
                Image("background-mini-quiz-v01")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    PlayStoryNavigationView(
                        widthRatio: widthRatio,
                        heightRatio: heightRatio,
                        title: viewModel.story.storyName,
                        buttonColor: .yellow,
                        onTapHomeButton: {
                            dismiss()
                        },
                        onTapAudioButton: {
                            textToSpeechHelper.speakIndonesian(instruction)
                        },
                        showAudioButton: false, // Pass 'false' to hide the audio button
                        titleOverlayReversed: true
                    )
                    .padding(.top, 38 * heightRatio)
                    .padding(.horizontal, 46 * widthRatio)
                    Spacer()
                }
                
                VStack {
                    Text(instruction)
                        .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("FSBlack"))
                        .padding(.bottom, 16 * heightRatio)
                    
                    MiniGameOptionArrayView(widthRatio: widthRatio, heightRatio: heightRatio)
                        .padding(.leading, 12 * widthRatio)
                        .padding(.bottom, 27 * heightRatio)
                        .environmentObject(viewModel)
                    
                    Spacer()
                }
                .frame(width: 1097 * widthRatio)
                .padding(.top, 127 * heightRatio)
                
                VStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 40 * heightRatio)
                            .foregroundStyle(Color("FSWhite"))
                            .frame(width: 1195 * widthRatio, height: 220 * heightRatio)
                            .shadow(color: Color(.fsBlack).opacity(0.1), radius: 10, y: -4 * heightRatio)
                        MiniGameAnswerArrayView(widthRatio: widthRatio, heightRatio: heightRatio)
                            .padding(.leading, 80 * widthRatio)
                            .padding(.top, 20 * heightRatio)
                            .padding(.bottom, 36 * heightRatio)
                            .environmentObject(viewModel)
                    }
                }
                
                HandTapOverlay(widthRatio: widthRatio, heightRatio: heightRatio)
                    .opacity(viewModel.isTutorialShown ? 1 : 0)
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.3)) {
                            viewModel.isTutorialShown = false
                        }
                        viewModel.restartTutorialTimer()
                    }
            }
            .sheet(isPresented: $viewModel.isAllCorrect,
                   onDismiss: {
                viewModel.isTutorialShown = false
                viewModel.startTutorialTimer()
            },
                   content: {
                ZStack {
                    Color("FSYellow1")
                    MiniQuizModalView(widthRatio: widthRatio, heightRatio: heightRatio)
                        .environmentObject(viewModel)
                }
                .onAppear(perform: {
                    viewModel.tutorialTimer?.invalidate()
                    textToSpeechHelper.stopSpeaking()
                })
                .presentationDetents([.height(727 * heightRatio)])
            })
        }
        .background(Color("FSYellow1"))
        .navigationBarBackButtonHidden()
        .onChange(of: viewModel.currentlyCheckedIndex) { _, value in
            if value == viewModel.correctAnswer.count {
                viewModel.isAllCorrect = true
            }
        }
        .onChange(of: viewModel.isDismissed) { _, value in
            if value {
                dismiss()
            }
        }
        .onAppear {
            viewModel.isTutorialShown = false
            viewModel.startTutorialTimer()
        }
        .onDisappear {
            viewModel.tutorialTimer?.invalidate()
        }
    }
}
