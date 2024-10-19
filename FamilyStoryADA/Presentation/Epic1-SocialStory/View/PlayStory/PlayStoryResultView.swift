//
//  PlayStoryResultView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 10/10/24.
//

import SwiftUI

struct PlayStoryResultView: View {
    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            VStack {
                PlayStoryNavigationView(heightRatio: heightRatio, title: "title", buttonColor: .yellow, onTapHomeButton: {}, onTapAudioButton: {})
                Spacer().frame(width: 85 * heightRatio)
                ZStack {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: 727 * widthRatio, height: 442 * heightRatio)
                        .cornerRadius(20 * heightRatio)
                    VStack {
                        Rectangle()
                            .foregroundColor(.black)
                          .frame(width: 289 * widthRatio, height: 189 * heightRatio)
                          .cornerRadius(12 * heightRatio)
                        Text("Good job!")
                            .bold()
                            .font(.system(size: 32 * heightRatio))
                    }
                }
                Spacer().frame(width: 192 * heightRatio)
            }
            .padding(47 * heightRatio)
        }
    }
}

#Preview {
    PlayStoryResultView()
}

