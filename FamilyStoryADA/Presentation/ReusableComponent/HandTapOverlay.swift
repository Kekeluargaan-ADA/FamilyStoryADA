//
//  HandTapOverlay.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 12/11/24.
//

import SwiftUI

struct HandTapOverlay: View {
    var body: some View {
        ZStack {
            Color("FSBlack")
                .opacity(0.5)
                .ignoresSafeArea()
            VStack (spacing: 11) {
                LottieView(animationName: "hand-tap-gesture", width: 217, height: 218)
                    .frame(width: 217, height: 218)
                Text("Tekan kartu untuk memilih")
                    .font(Font.custom("Fredoka", size: 48, relativeTo: .largeTitle))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("FSWhite"))
            }
        }
    }
}

#Preview {
    HandTapOverlay()
}
