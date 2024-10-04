//
//  PhotoPickerView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 04/10/24.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView<PickerButton: View>: View {
    @State var imageSelection: PhotosPickerItem? = nil
    @Binding var selectedPhoto: PhotoRequest?
    let pickerButton: PickerButton
    
    var body: some View {
        PhotosPicker(
            selection: $imageSelection,
            matching: .images,
            photoLibrary: .shared(),
            label: {
                pickerButton
            }
        )
        .onChange(of: imageSelection) {
            Task { @MainActor in
                if let data = try? await imageSelection?.loadTransferable(type: Data.self) {
                    selectedPhoto = .init(photo: UIImage(data: data), path: CameraDelegate.saveImageToAppStorage(UIImage(data: data) ?? UIImage()))
                    return
                }
            }
        }
    }
}

#Preview {
    PhotoPickerView(selectedPhoto: .constant(PhotoRequest(photo: UIImage(), path: "")), pickerButton: Image(systemName: "camera.circle.fill")
        .font(.system(size: 50))
        .foregroundColor(.gray)
    )
}
