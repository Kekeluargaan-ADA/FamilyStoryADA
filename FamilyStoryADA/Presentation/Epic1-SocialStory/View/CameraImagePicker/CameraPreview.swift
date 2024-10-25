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
    
    func makeUIView(context: Context) -> VideoPreviewView {
        
        let view = VideoPreviewView()
        view.backgroundColor = .black
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspect
        view.videoPreviewLayer.connection?.videoOrientation = .landscapeRight
        
        // Add a tap gesture recognizer to the view
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTapGesture(_:)))
        view.addGestureRecognizer(tapGesture)
        
        DispatchQueue.main.async {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            UIViewController.attemptRotationToDeviceOrientation()
        }
        return view
    }
    
    public func updateUIView(_ uiView: VideoPreviewView, context: Context) { }
    
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
    @Binding var selectedImage: UIImage?  // This will hold the selected image
    @Binding var isPhotoCaptured: Bool
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
                            self.parent.selectedImage = uiImage
                            self.parent.isPhotoCaptured = true
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
