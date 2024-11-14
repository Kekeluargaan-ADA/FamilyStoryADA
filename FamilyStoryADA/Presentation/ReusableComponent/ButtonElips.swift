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
    var buttonPreset: ButtonPreset
    var buttonStyle: ButtonStyle
    
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
                    .font(Font.custom("Fredoka", size: 20, relativeTo: .title3))
                    .fontWeight(.medium)
                    .foregroundStyle(textColor)
            }
            .frame(width: 190, height: 70)
            .clipShape(
                RoundedRectangle(cornerRadius: 40)
            )
        }
        .frame(width: 200, height: 80)
        .clipShape(
            RoundedRectangle(cornerRadius: 40)
        )
    }
}

#Preview {
    ButtonElips(text: "Text", buttonPreset: .yellow, buttonStyle: .primary)
}
