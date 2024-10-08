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
    @Binding private var isCapturedImage: Bool
    @Binding private var photosPickerItem: PhotosPickerItem?
    private var didCrop: ((CropView.CroppedRect) -> ())?
    private var didCancel: (() -> ())?
    @ViewBuilder private var label: () -> Label
    
    init(style: CroppedPhotosPickerCroppingStyle = .default,
         options: CroppedPhotosPickerOptions = .init(),
         selection: Binding<SelectedImage?>,
         isCapturedImage: Binding<Bool>,
         photosPickerItem: Binding<PhotosPickerItem?>,
         didCrop: ((CropView.CroppedRect) -> Void)? = nil,
         didCancel: (() -> Void)? = nil,
         @ViewBuilder label: @escaping () -> Label) {
        self.style = style
        self.options = options
        self._selection = selection
        self._isCapturedImage = isCapturedImage
        self._photosPickerItem = photosPickerItem
        self.didCrop = didCrop
        self.didCancel = didCancel
        self.label = label
    }

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
                    isCapturedImage = true
                }
            }
        }
    }
}
