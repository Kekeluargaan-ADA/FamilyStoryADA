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
                        .font(Font.custom("Fredoka", size: 32, relativeTo: .title))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("FSBlack"))
                        .padding(.bottom, 28)
                    
                    MiniGameOptionArrayView()
                        .padding(.horizontal, 80)
                        .padding(.bottom, 27)
                        .environmentObject(viewModel)
                    
                    ZStack {
                        
                    }
                }
            }
            .background(Color("FSYellow1"))
        .navigationBarBackButtonHidden()
    }
}
