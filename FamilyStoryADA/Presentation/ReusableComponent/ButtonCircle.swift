//
//  ExampleComponent.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 24/09/24.
//

import SwiftUI

enum ButtonPreset {
    case blue, yellow
}

struct ButtonCircle: View {
    let heightRatio: CGFloat
    let buttonImage: String
    let buttonColor: ButtonPreset
    
    var body: some View {
        Circle()
            .foregroundStyle(buttonColor == .blue ? Color("FSSecondaryBlue4") : Color("FSWhite"))
            .frame(height: 64 * heightRatio)
            .overlay(
                Image(systemName: buttonImage)
                    .foregroundStyle(buttonColor == .blue ? Color("FSBlue9") : Color("FSPrimaryYellow5"))
                    .font(.system(size: 26 * heightRatio))
                    .bold()
            )
    }
}

#Preview {
    ButtonCircle(heightRatio: 1.0, buttonImage: "house", buttonColor: .blue)
}
