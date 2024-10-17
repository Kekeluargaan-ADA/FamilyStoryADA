//
//  CategoryCircleView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//

import SwiftUI

enum CategoryColorState {
    case selected
    case unselected
    
    var backgroundColor: Color {
        switch self {
        case .selected:
            return Color("FSActiveYellow")
        case .unselected:
            return Color("FSSecondaryBlue4")
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .selected:
            return .black
        case .unselected:
            return Color("FSBlue9")
        }
    }
}

struct CategoryCircleView: View {
    let heightRatio: CGFloat
    let widthRatio: CGFloat
    let buttonImage: String
    let text: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var colorState: CategoryColorState {
        return isSelected ? .selected : .unselected
    }
    
    var body: some View {
        VStack {
            Button(action: {
                onTap()
            }) {
                ZStack {
                    if isSelected {
                        Circle()
                            .foregroundStyle(Color("FSWhite"))
                            .frame(height: 96 * heightRatio)
                    }
                    Circle()
                        .foregroundStyle(colorState.backgroundColor)
                        .frame(height: 64 * heightRatio)
                        .overlay(
                            Image(systemName: buttonImage)
                                .foregroundStyle(colorState.foregroundColor)
                                .font(.system(size: 26 * heightRatio))
                                .bold()
                        )
                }
            }
            .buttonStyle(.plain)
            Spacer().frame(height: 8 * heightRatio)
            if isSelected {
                Text(text)
                    .offset(y: -16 * heightRatio)
            }
            else {
                Text(text)
            }
        }
        .padding(20 * heightRatio)
    }
}



#Preview {
    CategoryCircleView(heightRatio: 1, widthRatio: 1, buttonImage: "photo.fill", text: "Text ", isSelected: true, onTap: {})
}
