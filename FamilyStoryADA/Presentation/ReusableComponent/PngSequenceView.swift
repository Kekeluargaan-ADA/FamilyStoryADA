//
//  PngSequenceView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 17/10/24.
//

import SwiftUI

struct PNGSequenceView: View {
    @State private var currentFrame = 0
    private let frameCount = 24
    private let frameDuration: Double = 1.0 / 12.0 // 12 frames per second
    
    var body: some View {
        Image("MenggosokGigiScene1_\(String(format: "%02d", currentFrame))")
            .resizable()
            .scaledToFit()
            .onAppear {
                startAnimation()
            }
    }
    
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in
            currentFrame = (currentFrame + 1) % frameCount
        }
    }
}

struct PNGSequenceView_Previews: PreviewProvider {
    static var previews: some View {
        PNGSequenceView()
    }
}
