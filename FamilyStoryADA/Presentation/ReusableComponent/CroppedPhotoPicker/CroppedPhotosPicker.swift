//
//  CroppedPhotosPicker.swift
//  CroppedPhotosPickerDemo
//
//  Created by Alex Nagy on 16.04.2024.
//

import SwiftUI
import PhotosUI
import CropViewController
import TOCropViewController

struct CroppedPhotosPicker<Label: View>: View {
    
    private var style: CroppedPhotosPickerCroppingStyle
    private var options: CroppedPhotosPickerOptions
    @Binding private var selection: SelectedImage?
    private var didCrop: ((CropView.CroppedRect) -> ())?
    private var didCancel: (() -> ())?
    @ViewBuilder private var label: () -> Label
    
    init(style: CroppedPhotosPickerCroppingStyle = .default,
         options: CroppedPhotosPickerOptions = .init(),
         selection: Binding<SelectedImage?>,
         didCrop: ((CropView.CroppedRect) -> Void)? = nil,
         didCancel: (() -> Void)? = nil,
         @ViewBuilder label: @escaping () -> Label) {
        self.style = style
        self.options = options
        self._selection = selection
        self.didCrop = didCrop
        self.didCancel = didCancel
        self.label = label
    }
    
    @State private var photosPickerItem: PhotosPickerItem?

    var body: some View {
        PhotosPicker(selection: $photosPickerItem) {
            label()
        }
        .onChange(of: photosPickerItem) { _, newValue in
            if let newValue {
                Task {
                    let uiImage = await newValue.convert()
                    guard let uiImage else { return }
                    selection = SelectedImage(image: uiImage)
                }
            }
        }
//        .sheet(item: $selectedImage) { selectedImage in
//            CropView(image: selectedImage.image, croppingStyle: style, croppingOptions: options) { image in
//                self.selectedImage = nil
//                self.photosPickerItem = nil
//                self.selection = image.image
//                self.didCrop?(CropView.CroppedRect(rect: image.rect, angle: image.angle))
//            } didCropToCircularImage: { image in
//                self.selectedImage = nil
//                self.photosPickerItem = nil
//                self.selection = image.image
//                self.didCrop?(CropView.CroppedRect(rect: image.rect, angle: image.angle))
//            } didCropImageToRect: { _ in
//                
//            } didFinishCancelled: { _ in
//                self.selectedImage = nil
//                self.photosPickerItem = nil
//                didCancel?()
//            }
//            .ignoresSafeArea()
//        }
    }
}
