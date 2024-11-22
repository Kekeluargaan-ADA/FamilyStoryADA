//
//  NewStoryCardView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import SwiftUI

struct NewStoryCardView: View {
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16 * heightRatio)
                .foregroundStyle(Color("FSBlue1"))
            ZStack {
                RoundedRectangle(cornerRadius: 15 * heightRatio)
                    .stroke(style: StrokeStyle(lineWidth: 2 * widthRatio, dash: [5]))
                    .frame(width: 354 * widthRatio, height: 320 * heightRatio)
                    .foregroundColor(Color("FSBorderBlue7"))
                
                VStack {
                    Circle()
                        .frame(width: 52 * widthRatio, height: 52 * heightRatio)
                        .foregroundColor(Color("FSSecondaryBlue4"))
                        .overlay(
                            Image(systemName: "plus")
                                .font(.system(size: 24 * heightRatio, weight: .bold))
                                .foregroundColor(Color("FSBlue9"))
                        )
                    
                    Text("Buat Cerita")
                        .font(Font.custom("Fredoka", size: 20 * heightRatio, relativeTo: .title3))
                        .fontWeight(.medium)
                        .foregroundColor(Color("FSBlue9"))
                }
            }
        }
    }
}

#Preview {
    NewStoryCardView(widthRatio: 1, heightRatio: 1)
}
