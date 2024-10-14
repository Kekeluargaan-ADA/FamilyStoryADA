//
//  PlayStoryView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 10/10/24.
//

import SwiftUI

struct PlayStoryView: View {
    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            VStack {
                Spacer()
                PlayStoryNavigationView(heightRatio: heightRatio)
                Spacer().frame(height: 21 * heightRatio)
                ZStack {
                    Rectangle()
                        .foregroundStyle(.gray)
                        .frame(width: 1055 * widthRatio, height: 519 * heightRatio)
                    HStack(spacing: 0) {
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
                        .padding(.leading, -32 * heightRatio)
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
                        .padding(.trailing, -32 * heightRatio)
                    }
                    .frame(width: 1055 * widthRatio, height: 519 * heightRatio)
                }
                Spacer().frame(height: 55 * heightRatio)
                Text("Text")
                    .font(.system(size: 32 * heightRatio))
                    .fontWeight(.bold)
                Spacer().frame(height: 55 * heightRatio)
            }
            .padding(47 * heightRatio)
        }
    }
}

#Preview {
    PlayStoryView()
}

