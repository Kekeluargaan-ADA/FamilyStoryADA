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
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        VStack {
            ZStack {
                if let image = imagePath {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 152 * widthRatio, height: 93.37 * heightRatio)
                        .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                } else {
                    RoundedRectangle(cornerRadius: 12 * heightRatio)
                        .foregroundStyle(Color("FSWhite"))
                        .frame(width: 152 * widthRatio, height: 93.37 * heightRatio)
                }
                if isSelected {
                    RoundedRectangle(cornerRadius: 12 * heightRatio)
                        .strokeBorder(Color("FSBlue9"), lineWidth: 3 * widthRatio)
                        .foregroundStyle(Color.clear)
                        .frame(width: 152 * widthRatio, height: 93.37 * heightRatio)
                        
                }
            }
            Text("\(order)")
                .font(.system(size: 14 * heightRatio))
                .fontWeight(.medium)
                .foregroundStyle(Color("FSBlue9"))
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

#Preview {
    DraggedPageView(imagePath: UIImage(imageLiteralResourceName: "DummyImage"), order: 1, isSelected: true, widthRatio: 1, heightRatio: 1)
}
