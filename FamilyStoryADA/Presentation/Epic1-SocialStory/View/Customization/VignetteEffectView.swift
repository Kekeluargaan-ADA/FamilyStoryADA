//
//  VignetteEffectView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 05/11/24.
//

import SwiftUI

struct VignetteEffectView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
            startPoint: .top,
            endPoint: .center
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    VignetteEffectView()
}
