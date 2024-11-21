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
    var isIntroduction: Bool
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
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
                if isIntroduction {
                    ZStack {
                        Circle()
                            .frame(width: 16 * widthRatio, height: 16 * heightRatio)
                            .foregroundStyle(Color(.fsBlue9))
                        Image(systemName: "pin.fill")
                            .font(.system(size: 9 * heightRatio))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.fsWhite))
                    }
                    .padding(.trailing, 8 * widthRatio)
                    .padding(.top, 6 * heightRatio)
                }
            }
            Text("\(order)")
                .font(.system(size: 14 * heightRatio))
                .fontWeight(.medium)
                .foregroundStyle(Color("FSBlue9"))
        }
        .listRowBackground(Color(.fsBlue6))
        .listRowSeparator(.hidden)
    }
}

#Preview {
    DraggedPageView(imagePath: UIImage(imageLiteralResourceName: "DummyImage"), order: 1, isSelected: true, isIntroduction: true, widthRatio: 1, heightRatio: 1)
}
