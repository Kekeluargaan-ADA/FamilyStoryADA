//
//  ImagePreviewView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 08/10/24.
//

import SwiftUI

struct ImagePreviewView: View {
    @Binding var image: SelectedImage?
    private var didCrop: ((CropView.CroppedRect) -> ())?
    private var didCancel: (() -> ())?
    
    var body: some View {
        if let capturedImage = image?.image {
            CropView(image: capturedImage, croppingStyle: .default, croppingOptions: .init()) { image in
                self.didCrop?(CropView.CroppedRect(rect: image.rect, angle: image.angle))
            } didCropToCircularImage: { image in
                self.didCrop?(CropView.CroppedRect(rect: image.rect, angle: image.angle))
            } didCropImageToRect: { _ in
                // handle rect cropping result
            } didFinishCancelled: { _ in
                image = nil
            }
            .ignoresSafeArea()
        } else {
            EmptyView()
        }
    }
}

//#Preview {
//    ImagePreviewView(image: .constant(UIImage()))
//}
