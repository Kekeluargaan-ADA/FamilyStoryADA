//
//  CropView.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 20/10/24.
//
import SwiftUI


struct CropImageView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: CameraViewModel
    
    var body: some View {
        if let image = viewModel.savedImage {
            CropView(image: image, croppingStyle: .default, croppingOptions: .init()) { image in
                // Handle cropped image here
                handleCroppedImage(image)
                dismiss()
            } didCropImageToRect: { _ in
                // Handle additional crop rect logic if needed
            } didFinishCancelled: { _ in
                // Handle cancel action
                handleCancelAction()
                dismiss()
            }
            .ignoresSafeArea()
        }
    }
    
    private func handleCroppedImage(_ image: CropView.CroppedImage) {
        // Update the viewModel's saved image after cropping
//        viewModel.capturedImage = nil
        viewModel.photosPickerItem = nil
        
        viewModel.savedImage = image.image
        viewModel.isPhotoCaptured = false
        
        // Dismiss crop view after saving
        viewModel.showCropView = false
    }
    
    private func handleCancelAction() {
        viewModel.savedImage = nil
        viewModel.photosPickerItem = nil
        viewModel.isPhotoCaptured = false
        viewModel.showCropView = false
    }
}
