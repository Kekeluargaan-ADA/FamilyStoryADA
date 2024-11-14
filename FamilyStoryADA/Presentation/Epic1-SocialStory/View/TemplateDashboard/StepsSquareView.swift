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
                .frame(width: 280, height: 172)
                .cornerRadius(8)
                .overlay {
                    VStack (alignment: .center, spacing: 6) {
                        Image(imageAssetName ?? "")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 186, height: 115)
                            .cornerRadius(8)
                        Text(text ?? "")
                          .font(
                            Font.custom("Fredoka", size: 14)
                              .weight(.medium)
                          )
                          .multilineTextAlignment(.center)
                          .frame(width: 214)
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
                      .font(Font.custom("Fredoka", size: 12))
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

