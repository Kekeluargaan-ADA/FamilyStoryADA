//
//  LottieView.swift
//  CoreLocationComponent
//
//  Created by Lucinda Artahni on 15/07/24.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    let animationView = LottieAnimationView()
    var animationName: String
    var width: CGFloat = 1600 // Default width
    var height: CGFloat = 900 // Default height
    var loopMode: LottieLoopMode = .loop
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        animationView.animation = LottieAnimation.named(animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalToConstant: width),
            animationView.heightAnchor.constraint(equalToConstant: height),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        animationView.animation = LottieAnimation.named(animationName)
        animationView.play()
    }
}

#Preview {
    // Example usage with default size
    LottieView(animationName: "hand-tap-gesture")
}
