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
    let text: String?
    let imageAssetName: String?
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .foregroundColor(Color("FSWhite"))
                .frame(width: 280 * widthRatio, height: 172 * heightRatio)
                .cornerRadius(8 * heightRatio)
                .overlay {
                    VStack (alignment: .center, spacing: 6 * heightRatio) {
                        Image(imageAssetName ?? "")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 186 * widthRatio, height: 115 * heightRatio)
                            .cornerRadius(8 * heightRatio)
                        Text(text ?? "")
                          .font(
                            Font.custom("Fredoka", size: 14 * heightRatio)
                              .weight(.medium)
                          )
                          .multilineTextAlignment(.center)
                          .frame(width: 214 * widthRatio)
                          .lineLimit(2)
                          .foregroundColor(Color("FSBlack"))
                    }
                }
                 
            
            Circle()
                .frame(width: 16 * heightRatio, height: 16 * heightRatio)
                .offset(x: 4 * widthRatio, y: 4 * heightRatio)
                .foregroundStyle(Color("FSBlue3"))
                .overlay(
                    Text("\(order)")
                        .font(Font.custom("Fredoka", size: 12 * heightRatio))
                      .foregroundColor(Color("FSBlue9"))
                      .offset(x: 4 * widthRatio, y: 4 * heightRatio)
                )
        }
        .padding(4 * heightRatio)
    }
}


#Preview {
    StepsSquareView(heightRatio: 1, widthRatio: 1, order: 1, text: "Ambil sikat gigi dan makan makanan bergizi bersama sama dengan orang lain.", imageAssetName: "ss01-animated-scene01")
}

