//
//  PlayStoryClosingView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 10/10/24.
//

import SwiftUI

struct PlayStoryClosingView: View {
    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            VStack {
                PlayStoryNavigationView(heightRatio: heightRatio)
                HStack {
                    Button(action: {
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
                    Spacer()
                    VStack {
                        Spacer().frame(width: 24 * heightRatio)
                        Rectangle()
                            .frame(width: 400 * widthRatio, height: 500 * heightRatio)
                        Spacer().frame(width: 48 * heightRatio)
                        Text("Saya ingin menggosok gigi")
                            .bold()
                            .font(.system(size: 32 * heightRatio))
                        Spacer().frame(width: 98 * heightRatio)
                    }
                    Spacer()
                    Button(action: {
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
                }
            }
            .padding(47 * heightRatio)
        }
    }
}

#Preview {
    PlayStoryClosingView()
}

