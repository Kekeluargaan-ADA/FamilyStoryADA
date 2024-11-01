//
//  CropView.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 20/10/24.
//
import SwiftUI

enum CroppingStyleType {
    case portrait, landscape
}

struct CropImageView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: CameraViewModel
    var croppingStyle: CroppingStyleType
    
    var style: CroppedPhotosPickerOptions {
        switch croppingStyle {
        case .portrait:
            return .init(customAspectRatio: CGSize(width: 3, height: 4))
        case .landscape:
            return .init(customAspectRatio: CGSize(width: 16, height: 9))
        }
    }
    
    var body: some View {
        if let image = viewModel.savedImage {
            CropView(image: image, croppingStyle: .default, croppingOptions: style) { image in
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
            .onAppear() {
                print(viewModel.savedImage)
            }
        } else {
            EmptyView()
                .onAppear() {
                    print(viewModel.savedImage)
                }
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
