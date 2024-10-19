//
//  AnotherView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 19/10/24.
//

import SwiftUI

struct AnotherView: View {
    @AppStorage("selectedImageUUID") var selectedImageUUID: String?
    
    var body: some View {
        VStack {
            if let uuid = selectedImageUUID {
                // Load the image from AppStorage using the UUID
                if let image = loadImageFromAppStorage(uuid: uuid) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                    Text(selectedImageUUID!)
                } else {
                    Text("Image not found.")
                }
            } else {
                Text("No image selected.")
            }
        }
        .padding()
    }

    // Helper function to load image by UUID
    func loadImageFromAppStorage(uuid: String) -> UIImage? {
        let fileManager = FileManager.default
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent(uuid)
            if let imageData = try? Data(contentsOf: fileURL) {
                return UIImage(data: imageData)
            }
        }
        return nil
    }
}
