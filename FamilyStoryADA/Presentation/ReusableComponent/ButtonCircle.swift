//
//  ExampleComponent.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 24/09/24.
//

import SwiftUI

struct ButtonCircle: View {
    let heightRatio: CGFloat
    let buttonImage: String
    
    var body: some View {
        Button(action: {
            // TODO: add navigation
        }) {
            Circle()
                .foregroundStyle(.gray)
                .frame(height: 64 * heightRatio)
                .overlay(
                    Image(systemName: buttonImage)
                        .font(.system(size: 26 * heightRatio))
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ButtonCircle(heightRatio: 1.0, buttonImage: "house")
}
