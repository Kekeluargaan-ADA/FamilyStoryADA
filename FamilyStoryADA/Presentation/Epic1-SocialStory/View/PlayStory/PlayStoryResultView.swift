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
    @State var isMiniQuizPresented: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            VStack {
                PlayStoryNavigationView(heightRatio: heightRatio, title: playStoryViewModel.story.storyName, buttonColor: .yellow, onTapHomeButton: {
                    playStoryViewModel.isStoryCompleted = true
                }, onTapAudioButton: {})
                    .padding(.horizontal, 46 * widthRatio)
                    .padding(.top, 46 * heightRatio)
                    .padding(.bottom, 24 * heightRatio)
                
                Text("Selesai!")
                    .font(Font.custom("Fredoka", size: 64 * heightRatio, relativeTo: .largeTitle))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("FSBlack"))
                    .padding(.bottom, 20 * heightRatio)
                
                Image("FinishStoryMenggosokGigi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 600 * widthRatio, height: 371.61 * heightRatio)
                    .padding(.bottom, 25 * heightRatio)
                
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
//                        playStoryViewModel.isStoryCompleted = true
                        isMiniQuizPresented = true
                    }, label: {
                        ButtonElips(text: "Main", buttonPreset: .yellow, buttonStyle: .primary)
                    })
                }
            }
            NavigationLink(isActive: $isMiniQuizPresented, destination: {
                MiniQuizView(story: playStoryViewModel.story)
            }, label: {})
        }
        .background(Color("FSYellow1"))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    PlayStoryResultView()
}

