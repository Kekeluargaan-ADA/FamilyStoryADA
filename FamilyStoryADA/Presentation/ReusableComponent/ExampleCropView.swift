//
//  ContentView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 07/10/24.
//


//
//  ContentView.swift
//  CroppedPhotosPickerDemo
//
//  Created by Alex Nagy on 16.04.2024.
//

import SwiftUI

struct ExampleCropView: View {
    
    @State private var selection: UIImage?
    let croppingOptions = CroppedPhotosPickerOptions(doneButtonTitle: "Select",
                                                     doneButtonColor: .orange)
    
    var body: some View {
        VStack {
            if let selection {
                Image(uiImage: selection)
                    .resizable()
                    .scaledToFit()
            }
            
            CroppedPhotosPicker(style: .default, options: croppingOptions, selection: $selection) { rect in
                print("Did crop to rect: \(rect)")
            } didCancel: {
                print("Did cancel")
            } label: {
                Text("Pick and crop image")
            }
        }
        .padding()
    }
}

#Preview {
    ExampleCropView()
}
