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
    @Binding var isReadyToPlay: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.showsPlaybackControls = false
        playerViewController.videoGravity = .resizeAspectFill
        
        // Add observer for `isReadyForDisplay`
        playerViewController.addObserver(context.coordinator, forKeyPath: #keyPath(AVPlayerViewController.isReadyForDisplay), options: [.new, .initial], context: nil)
        
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
    
    static func dismantleUIViewController(_ uiViewController: AVPlayerViewController, coordinator: Coordinator) {
        // Remove observer when view controller is dismantled
        uiViewController.removeObserver(coordinator, forKeyPath: #keyPath(AVPlayerViewController.isReadyForDisplay))
    }
    
    class Coordinator: NSObject {
        var parent: CustomVideoPlayerView
        
        init(_ parent: CustomVideoPlayerView) {
            self.parent = parent
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == #keyPath(AVPlayerViewController.isReadyForDisplay),
               let playerViewController = object as? AVPlayerViewController {
                DispatchQueue.main.async {
                    self.parent.isReadyToPlay = playerViewController.isReadyForDisplay
                }
            }
        }
    }
}
