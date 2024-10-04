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
    @Binding var uiImage: UIImage?
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
                    uiImage = UIImage(data:data)
                    print(uiImage)
                    return
                }
            }
        }
    }
}

#Preview {
    PhotoPickerView(uiImage: .constant(UIImage()), pickerButton: Image(systemName: "camera.circle.fill")
        .font(.system(size: 50))
        .foregroundColor(.gray)
    )
}
