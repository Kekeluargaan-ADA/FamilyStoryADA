//
//  DroppedPageTargetCustomizationView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import SwiftUI

struct DroppedPageTargetCustomizationView: View {
    var isSelected: Bool
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        VStack {
            if isSelected {
                ZStack {
                    RoundedRectangle(cornerRadius: 8 * heightRatio)
                        .stroke(style: StrokeStyle(lineWidth: 2 * widthRatio, dash: [5, 5]))
                        .foregroundStyle(Color("FSBlue9"))
                        .background(Color("FSWhite"))
                        .frame(width: 152 * widthRatio, height: 40 * heightRatio)
                    Image(systemName: "plus.circle")
                        .foregroundStyle(Color("FSBlue9"))
                }
            } else {
                RoundedRectangle(cornerRadius: 8 * heightRatio)
                    .fill(Color("FSBlue6"))
                    .frame(width: 152 * widthRatio, height: 12 * heightRatio)
            }
        }
        .background(Color.clear)
    }
}

#Preview {
    DroppedPageTargetCustomizationView(isSelected: true, widthRatio: 1, heightRatio: 1)
}
