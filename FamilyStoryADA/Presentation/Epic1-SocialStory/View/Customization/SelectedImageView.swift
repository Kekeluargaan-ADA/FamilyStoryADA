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
        }
        .navigationTitle("Selected Image")
    }
}
