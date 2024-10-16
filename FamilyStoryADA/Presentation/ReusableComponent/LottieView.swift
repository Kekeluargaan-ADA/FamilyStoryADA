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
    
    

    func makeUIView(context: Context) -> UIView {
        
        let width : CGFloat = 1600
        let height : CGFloat = 900
        
        let view = UIView()
        animationView.animation = LottieAnimation.named(animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .playOnce
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
        // Update the animation if needed
        animationView.animation = LottieAnimation.named(animationName)
        animationView.play()
    }
}

#Preview{
    LottieView(animationName: "MenggosokGigiScene1")
}

