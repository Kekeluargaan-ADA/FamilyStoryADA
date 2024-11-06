//
//  MiniGameView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 06/11/24.
//

import SwiftUI

struct MiniGameView: View {
    @StateObject var viewModel: MiniGameViewModel
    init(story: StoryEntity) {
        _viewModel = StateObject(wrappedValue: MiniGameViewModel(story: story))
    }
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
                let heightRatio = ratios.heightRatio
                let widthRatio = ratios.widthRatio
                
                Spacer(minLength: 47)
                PlayStoryNavigationView(heightRatio: heightRatio, title: "Cara Menyikat Gigi", buttonColor: .yellow, onTapHomeButton: {}, onTapAudioButton: {})
                    .padding(.horizontal, 46)
                
                Spacer(minLength: 60)
                
                
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden()
    }
}
