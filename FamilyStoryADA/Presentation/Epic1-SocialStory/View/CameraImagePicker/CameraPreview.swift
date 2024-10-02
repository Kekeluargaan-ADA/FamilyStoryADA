//
//  CameraPreview.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 02/10/24.
//

import SwiftUI
import AVFoundation
import Foundation

// Camera Preview View
class VideoPreviewView: UIView {
    
    //Specify layer class
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
    
    //Get AVCaptireVideoPreviewLayer for config
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    
}

// Attach CameraPreviewView to SwiftUI View
struct CameraPreview: UIViewRepresentable {
    
    let session: AVCaptureSession
    
    // Create Camera UI View
    func makeUIView(context: Context) -> UIView {
        let view = VideoPreviewView()
        view.backgroundColor = .white //TODO: Make sure
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspect
        view.videoPreviewLayer.connection?.videoRotationAngle = .pi / 2
        return view
    }
    
    // Conforming function
    func updateUIView(_ uiView: UIView, context: Context) {}
}

