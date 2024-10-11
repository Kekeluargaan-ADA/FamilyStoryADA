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
                HStack {
                    ZStack {
                        Circle()
                            .foregroundStyle(.gray)
                            .frame(height: 64 * heightRatio)
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 31 * widthRatio, height: 26 * heightRatio)
                    }
                    Spacer()
                    Text("Cara Menyikat Gigi") // TODO: use data
                        .font(.system(size: 26 * heightRatio)) // Adjust font size
                        .fontWeight(.medium)
                    Spacer()
                    ZStack {
                        Circle()
                            .foregroundStyle(.gray)
                            .frame(height: 64 * heightRatio)
                        Image(systemName: "speaker.wave.2")
                            .resizable()
                            .frame(width: 33 * widthRatio, height: 26 * heightRatio)
                    }
                }
                Spacer().frame(height: 21 * heightRatio)
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(width: 1055 * widthRatio, height: 519 * heightRatio)
                Spacer().frame(height: 55 * heightRatio)
                Text("Ambil sikat gigi.")
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

