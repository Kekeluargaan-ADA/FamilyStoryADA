//
//  ExampleComponent.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 24/09/24.
//

import SwiftUI

enum ButtonPreset {
    case blue, yellow, grey
}

struct ButtonCircle: View {
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    let buttonImage: String
    let buttonColor: ButtonPreset
    var size: CGFloat?
    
    var body: some View {
        Circle()
            .foregroundStyle(buttonColor == .blue ? Color("FSSecondaryBlue4") : Color("FSPrimaryOrange5"))
            .frame(height: 64 * heightRatio)
            .overlay(
                ZStack {
                    if buttonColor == .yellow {
                        Image("button")
                            .resizable()
                            .scaledToFill()
                            .frame(width: size != nil ? size : 91 * widthRatio, height: size != nil ? size : 91 * heightRatio)
                    }
                    Image(systemName: buttonImage)
                        .foregroundStyle(buttonColor == .blue ? Color("FSBlue9") : Color("FSWhite"))
                        .font(.system(size: 26 * heightRatio))
                        .bold()
                }
                
            )
    }
}

#Preview {
    ButtonCircle(widthRatio: 1.0, heightRatio: 1.0, buttonImage: "house", buttonColor: .blue)
}
