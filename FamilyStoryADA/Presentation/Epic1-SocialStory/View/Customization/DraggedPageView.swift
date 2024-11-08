//
//  DraggedPageView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import SwiftUI

struct DraggedPageView: View {
    var imagePath: UIImage?
    var order: Int
    var isSelected: Bool
    
    var body: some View {
        VStack {
            ZStack {
                if let image = imagePath {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 152, height: 93.37)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(Color("FSWhite"))
                        .frame(width: 152, height: 93.37)
                }
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
    DraggedPageView(imagePath: UIImage(imageLiteralResourceName: "DummyImage"), order: 1, isSelected: true)
}
