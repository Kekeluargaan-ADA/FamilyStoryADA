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
            LottieView(animationName: "hand-tap-gesture", width: 217, height: 218)
        }
    }
}

#Preview {
    HandTapOverlay()
}
