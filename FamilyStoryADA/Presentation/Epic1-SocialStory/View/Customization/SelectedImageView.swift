//
//  SelectedImageView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 17/10/24.
//

import SwiftUI

struct SelectedImageView: View {
    var image: UIImage // Passed selected image

    var body: some View {
        VStack {
            Text("Selected Image")
                .font(.title)
                .padding()

            // Display the passed image
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .border(Color.green, width: 4) // Green border for selected image
                .padding()

            Spacer()

            // Save button
            Button(action: {
                saveImageToAppStorage(image: image)
            }) {
                Text("Save Image")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Selected Image")
    }

    // Function to save the image in app storage with a unique UUID
    func saveImageToAppStorage(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            print("Failed to get JPEG representation of UIImage")
            return
        }

        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "\(UUID().uuidString).jpg" // Use UUID for a unique filename
        let fileURL = documentDirectory.appendingPathComponent(fileName)

        print(fileName)
        do {
            try data.write(to: fileURL)
            print("Image saved successfully at \(fileURL)")
        } catch {
            print("Error saving image: \(error)")
        }
    }
}
