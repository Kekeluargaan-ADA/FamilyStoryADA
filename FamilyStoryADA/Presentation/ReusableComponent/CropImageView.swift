//
//  CropView.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 20/10/24.
//
import SwiftUI


struct CropImageView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedImage: UIImage?
    @Binding var showCropView: Bool
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        if let selectedImage = selectedImage {
            CropView(image: selectedImage, croppingStyle: .default, croppingOptions: .init()) { image in
                // Handle cropped image here
                handleCroppedImage(image)
                dismiss()
            } didCropImageToRect: { _ in
                // Handle additional crop rect logic if needed
            } didFinishCancelled: { _ in
                // Handle cancel action
                handleCancelAction()
            }
            .ignoresSafeArea()
        } else {
            EmptyView()
        }
    }
    
    private func handleCroppedImage(_ image: CropView.CroppedImage) {
        // Update the viewModel's saved image after cropping
        viewModel.capturedImage = nil
        viewModel.photosPickerItem = nil
        
        // Save image and get the filename
        let filename = CameraDelegate.saveImageToAppStorage(image.image)
        viewModel.savedImageFilename = filename
        viewModel.savedImage = CameraDelegate.loadImageFromAppStorage(named: filename)  // <-- Update the savedImage
        
        // Save the image to the gallery
        CameraDelegate.saveImageToGallery(image.image)
        
        // Dismiss crop view after saving
        showCropView = false
    }
    
    private func handleCancelAction() {
        viewModel.capturedImage = nil
        viewModel.photosPickerItem = nil
        showCropView = false
    }
}
