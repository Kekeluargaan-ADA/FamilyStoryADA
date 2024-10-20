//
//  StepsSquareView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 20/10/24.
//

import SwiftUI

struct StepsSquareView: View {
    let heightRatio: CGFloat
    let widthRatio: CGFloat
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .foregroundColor(Color("FSWhite"))
                .frame(width: 280 * widthRatio, height: 172 * heightRatio)
                .cornerRadius(8)
                .shadow(radius: 2 * heightRatio, y: 4 * heightRatio)
                .overlay(
                    Text("Ambil sikat gigi.")
                      .font(
                        Font.custom("Fredoka", size: 16)
                          .weight(.medium)
                      )
                      .foregroundColor(Color("FSBlack"))
                      .padding(.bottom, 16 * heightRatio), alignment: .bottom
                )
            
            Circle()
                .frame(width: 16 * heightRatio, height: 16 * heightRatio)
                .offset(x: 4 * widthRatio, y: 4 * heightRatio)
                .foregroundStyle(Color("FSBlue3"))
                .overlay(
                    Text("1")
                      .font(Font.custom("Fredoka", size: 12))
                      .foregroundColor(Color("FSBlue9"))
                      .offset(x: 4 * widthRatio, y: 4 * heightRatio)
                )
        }
        .padding(4 * heightRatio)
    }
}


#Preview {
    StepsSquareView(heightRatio: 1, widthRatio: 1)
}

