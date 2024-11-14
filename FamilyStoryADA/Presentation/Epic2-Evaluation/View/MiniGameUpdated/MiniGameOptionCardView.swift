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
    
    var body: some View {
        if isOption {
            ZStack {
                if let displayedImage = image {
                    Image(uiImage: displayedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 340, height: 191)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 16)
                        )
                    
                }else {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 340, height: 191)
                        .foregroundStyle(Color("FSWhite"))
                }
                
                RoundedRectangle(cornerRadius: 16)
                    .stroke(style: StrokeStyle(lineWidth: 5))
                    .frame(width: 340, height: 191)
                    .foregroundStyle(Color("FSWhite"))
            }
        } else {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 340, height: 191)
                .foregroundStyle(.clear)
        }
    }
}

#Preview {
    ZStack {
        Color(.red)
        MiniGameOptionCardView(image: .constant(UIImage(imageLiteralResourceName: "ss01-animated-scene01")), isOption: true)
        
    }
}
