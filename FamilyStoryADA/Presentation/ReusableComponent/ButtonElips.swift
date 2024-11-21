//
//  ButtonElips.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 20/10/24.
//

import SwiftUI

enum ButtonStyle {
    case primary, secondary
}

struct ButtonElips: View {
    var text: String
    var textSize: CGFloat?
    var buttonPreset: ButtonPreset
    var buttonStyle: ButtonStyle
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var buttonColor: Color {
        switch buttonPreset {
        case .blue:
            switch buttonStyle {
            case .primary:
                return Color("FSPrimaryBlue9")
            case .secondary:
                return Color("FSSecondaryBlue4")
            }
        case .yellow:
            switch buttonStyle {
            case .primary:
                return Color("FSPrimaryOrange5")
            case .secondary:
                return Color("FSSecondaryOrange2")
            }
        case .grey:
            return Color("FSGrey4")
        }
    }
    
    var textColor: Color {
        switch buttonPreset {
        case .blue:
            switch buttonStyle {
            case .primary:
                return Color("FSWhite")
            case .secondary:
                return Color("FSBlue9")
            }
        case .yellow:
            switch buttonStyle {
            case .primary:
                return Color("FSWhite")
            case .secondary:
                return Color("FSBlack")
            }
        case .grey:
            return Color("FSWhite")
        }
    }
    var body: some View {
        ZStack {
            Color("FSWhite")
            ZStack {
                buttonColor
                Text(text)
                    .font(Font.custom("Fredoka", size: textSize ?? 20 * heightRatio, relativeTo: .title3))
                    .fontWeight(.medium)
                    .foregroundStyle(textColor)
            }
            .frame(width: 190 * widthRatio, height: 70 * heightRatio)
            .clipShape(
                RoundedRectangle(cornerRadius: 40 * heightRatio)
            )
        }
        .frame(width: 200 * widthRatio, height: 80 * heightRatio)
        .clipShape(
            RoundedRectangle(cornerRadius: 40 * heightRatio)
        )
    }
}

#Preview {
    ButtonElips(text: "Text", buttonPreset: .yellow, buttonStyle: .primary, widthRatio: 1, heightRatio: 1)
}
