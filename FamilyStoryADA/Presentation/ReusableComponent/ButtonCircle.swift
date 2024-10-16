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
    let onTap: () -> Void
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            Circle()
                .foregroundStyle(Color("FSSecondaryBlue4"))
                .frame(height: 64 * heightRatio)
                .overlay(
                    Image(systemName: buttonImage)
                        .foregroundStyle(Color("FSBlue9"))
                        .font(.system(size: 26 * heightRatio))
                        .bold()
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ButtonCircle(heightRatio: 1.0, buttonImage: "house", onTap: {})
}
