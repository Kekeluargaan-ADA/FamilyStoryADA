//
//  VIdeoPlayerView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 28/10/24.
//

import Foundation
import AVFoundation
import SwiftUI
import AVKit

struct CustomVideoPlayerView: UIViewControllerRepresentable {
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.showsPlaybackControls = false
        playerViewController.videoGravity = .resizeAspectFill
        
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
}
