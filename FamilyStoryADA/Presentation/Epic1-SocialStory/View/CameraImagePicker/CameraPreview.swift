//
//  CameraPreview.swift
//  CustomCameraApp
//
//  Created by Amisha Italiya on 03/10/23.
//
import PhotosUI
import SwiftUI
import Photos
import AVFoundation // To access the camera related swift classes and methods

struct CameraPreview: UIViewRepresentable { // for attaching AVCaptureVideoPreviewLayer to SwiftUI View
    
    let session: AVCaptureSession
    var onTap: (CGPoint) -> Void
    var videoPreview: VideoPreviewView = VideoPreviewView()
    
    func makeUIView(context: Context) -> VideoPreviewView {
        
        videoPreview.backgroundColor = .black
        videoPreview.videoPreviewLayer.session = session
        videoPreview.videoPreviewLayer.frame = videoPreview.bounds
        videoPreview.videoPreviewLayer.videoGravity = .resizeAspect
        
        if videoPreview.videoPreviewLayer.connection == nil {
            videoPreview.transform = CGAffineTransform(rotationAngle:  3 * .pi / 2)
        } else {
            videoPreview.videoPreviewLayer.connection?.videoRotationAngle = 0
        }
        
        // Add a tap gesture recognizer to the view
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTapGesture(_:)))
        videoPreview.addGestureRecognizer(tapGesture)
        
//        DispatchQueue.main.async {
//            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
//            UIViewController.attemptRotationToDeviceOrientation()
//        }
        return videoPreview
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            let view = UIView(frame: UIScreen.main.bounds)
           videoPreview.videoPreviewLayer.frame = view.bounds
        }
      }
    
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        
        var parent: CameraPreview
        
        init(_ parent: CameraPreview) {
            self.parent = parent
        }
        
        @objc func handleTapGesture(_ sender: UITapGestureRecognizer) {
            let location = sender.location(in: sender.view)
            parent.onTap(location)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @EnvironmentObject var viewModel: CameraViewModel
    @Environment(\.dismiss) var dismiss  // Used to dismiss the picker

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images  // Only allow images
        config.selectionLimit = 1  // Allow only one image to be selected
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // No need to update anything here
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self, dismiss: dismiss)  // Pass the dismiss environment to the coordinator
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        let dismiss: DismissAction  // Capture the dismiss action

        init(_ parent: ImagePicker, dismiss: DismissAction) {
            self.parent = parent
            self.dismiss = dismiss  // Initialize dismiss action
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // Dismiss the picker view controller immediately
            dismiss()  // Call dismiss to close the picker
            
            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { (image, error) in
                    if let uiImage = image as? UIImage {
                        DispatchQueue.main.async {
                            self.parent.viewModel.savedImage = uiImage
                            self.parent.viewModel.isPhotoCaptured = true
                        }
                    }
                }
            }
        }
    }
}

extension UIViewController {
    func setLandscapeRightOrientation() {
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }
}
