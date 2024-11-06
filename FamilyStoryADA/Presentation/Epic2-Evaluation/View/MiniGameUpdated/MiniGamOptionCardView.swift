//
//  MiniGamOptionCardView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 06/11/24.
//

import SwiftUI

struct MiniGamOptionCardView: View {
    var image: UIImage?
    
    var body: some View {
        if let displayedImage = image {
            ZStack {
                Image(uiImage: displayedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 191)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 16)
                    )
                
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
        MiniGamOptionCardView(image: UIImage(imageLiteralResourceName: "MenggosokGigiScene1"))
        
    }
}
