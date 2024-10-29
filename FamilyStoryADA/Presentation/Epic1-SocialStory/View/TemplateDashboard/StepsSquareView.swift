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
    let order: Int
    let text: String
    let imageAssetName: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(imageAssetName)
                .resizable()
                .foregroundColor(Color("FSWhite"))
                .frame(width: 280, height: 172)
                .cornerRadius(8)
                .shadow(radius: 2 * heightRatio, y: 4 * heightRatio)
                .overlay(
                    Text(text)
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
                    Text("\(order)")
                      .font(Font.custom("Fredoka", size: 12))
                      .foregroundColor(Color("FSBlue9"))
                      .offset(x: 4 * widthRatio, y: 4 * heightRatio)
                )
        }
        .padding(4 * heightRatio)
    }
}


#Preview {
    StepsSquareView(heightRatio: 1, widthRatio: 1, order: 1, text: "Ambil sikat gigi.", imageAssetName: "MenggosokGigiScene1")
}

