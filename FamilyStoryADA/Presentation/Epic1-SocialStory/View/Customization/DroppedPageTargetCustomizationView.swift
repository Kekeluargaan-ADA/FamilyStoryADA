//
//  DroppedPageTargetCustomizationView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import SwiftUI

struct DroppedPageTargetCustomizationView: View {
    var isSelected: Bool
    var body: some View {
        VStack {
            if isSelected {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5, 5]))
                        .foregroundStyle(Color("FSBlue9"))
                        .background(Color("FSWhite"))
                        .frame(width: 152, height: 40)
                    Image(systemName: "plus.circle")
                        .foregroundStyle(Color("FSBlue9"))
                }
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("FSBlue6"))
                    .frame(width: 152, height: 12)
            }
        }
        .background(Color.clear)
    }
}

#Preview {
    DroppedPageTargetCustomizationView(isSelected: true)
}
