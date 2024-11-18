//
//  MiniGamOptionCardView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 06/11/24.
//

import SwiftUI

struct MiniGameOptionCardView: View {
    @Binding var image: UIImage?
    var isOption: Bool
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        if isOption {
            ZStack {
                if let displayedImage = image {
                    Image(uiImage: displayedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 340 * widthRatio, height: 191 * heightRatio)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 16 * heightRatio)
                        )
                    
                }else {
                    RoundedRectangle(cornerRadius: 16 * heightRatio)
                        .frame(width: 340 * widthRatio, height: 191 * heightRatio)
                        .foregroundStyle(Color("FSWhite"))
                }
                
                RoundedRectangle(cornerRadius: 16 * heightRatio)
                    .stroke(style: StrokeStyle(lineWidth: 5 * heightRatio))
                    .frame(width: 340 * widthRatio, height: 191 * heightRatio)
                    .foregroundStyle(Color("FSWhite"))
            }
        } else {
            RoundedRectangle(cornerRadius: 16 * heightRatio)
                .frame(width: 340 * widthRatio, height: 191 * heightRatio)
                .foregroundStyle(.clear)
        }
    }
}

#Preview {
    ZStack {
        Color(.red)
        MiniGameOptionCardView(image: .constant(UIImage(imageLiteralResourceName: "ss01-animated-scene01")), isOption: true, widthRatio: 1, heightRatio: 1)
        
    }
}
