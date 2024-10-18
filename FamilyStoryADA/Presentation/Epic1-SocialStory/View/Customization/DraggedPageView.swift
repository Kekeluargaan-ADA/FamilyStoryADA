//
//  DraggedPageView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import SwiftUI

struct DraggedPageView: View {
    var imagePath: String
    var order: Int
    var isSelected: Bool
    var body: some View {
        VStack {
            ZStack {
                Image(imagePath)
                    .resizable()
                    .frame(width: 152, height: 93.37)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                if isSelected {
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(Color("FSBlue9"), lineWidth: 3)
                        .foregroundStyle(Color.clear)
                        .frame(width: 152, height: 93.37)
                        
                }
            }
            Text("\(order)")
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundStyle(Color("FSBlue9"))
        }
    }
}

#Preview {
    DraggedPageView(imagePath: "DummyImage", order: 1, isSelected: true)
}
