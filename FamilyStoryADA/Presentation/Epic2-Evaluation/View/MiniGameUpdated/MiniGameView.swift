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
                VStack {
                    PlayStoryNavigationView(heightRatio: heightRatio, title: viewModel.story.storyName, buttonColor: .yellow, onTapHomeButton: {
                        dismiss()
                    }, onTapAudioButton: {
                        textToSpeechHelper.speakIndonesian(instruction)
                    })
                    .padding(.top, 47 * heightRatio)
                    .padding(.horizontal, 46 * widthRatio)
                    .padding(.bottom, 16 * heightRatio)
                    
                    Text(instruction)
                        .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("FSBlack"))
                        .padding(.bottom, 16 * heightRatio)
                    
                    MiniGameOptionArrayView()
                        .padding(.leading, 80 * widthRatio)
                        .padding(.bottom, 27 * heightRatio)
                        .environmentObject(viewModel)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .foregroundStyle(Color("FSWhite"))
                            .frame(width: 1195 * widthRatio, height: 220 * heightRatio)
                            .shadow(radius: 10, y: -4)
                        MiniGameAnswerArrayView()
                            .padding(.leading, 80 * widthRatio)
                            .padding(.top, 20 * heightRatio)
                            .padding(.bottom, 36 * heightRatio)
                            .environmentObject(viewModel)
                    }
                }
                
                HandTapOverlay()
                    .opacity(viewModel.isTutorialShown ? 1 : 0)
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.3)) {
                            viewModel.isTutorialShown = false
                        }
                        viewModel.restartTutorialTimer()
                    }
            }
        }
        .background(Color("FSYellow1"))
        .navigationBarBackButtonHidden()
        .onChange(of: viewModel.currentlyCheckedIndex) { value in
            if value == viewModel.correctAnswer.count {
                viewModel.isAllCorrect = true
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
                MiniQuizModalView()
                    .environmentObject(viewModel)
            }
            .onAppear(perform: {
                viewModel.tutorialTimer?.invalidate()
                textToSpeechHelper.stopSpeaking()
            })
            .presentationDetents([.height(727)])
        })
        .onChange(of: viewModel.isDismissed) { value in
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
