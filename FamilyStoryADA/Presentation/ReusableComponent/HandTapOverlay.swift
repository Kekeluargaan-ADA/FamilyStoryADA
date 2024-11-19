//
//  HandTapOverlay.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 12/11/24.
//

import SwiftUI

struct HandTapOverlay: View {
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    var body: some View {
        ZStack {
            Color("FSBlack")
                .opacity(0.5)
                .ignoresSafeArea()
            VStack (spacing: 11) {
                LottieView(animationName: "hand-tap-gesture", width: 217 * widthRatio, height: 218 * heightRatio)
                    .frame(width: 217 * widthRatio, height: 218 * heightRatio)
                Text("Tekan kartu untuk memilih")
                    .font(Font.custom("Fredoka", size: 48 * heightRatio, relativeTo: .largeTitle))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("FSWhite"))
            }
        }
    }
}

#Preview {
    HandTapOverlay(widthRatio: 1, heightRatio: 1)
}
