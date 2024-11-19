//
//  TenplateCardView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//
import SwiftUI

struct TemplateCardView: View {
    var template: TemplateEntity
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    var onTap: () -> Void

    var body: some View {
        Rectangle()
            .foregroundStyle(Color("FSWhite"))
            .frame(width: 354 * widthRatio, height: 280 * heightRatio)
            .cornerRadius(12 * heightRatio)
            .shadow(radius: 2 * heightRatio, y: 4 * heightRatio)
            .overlay(
                VStack(alignment: .leading) {
                    ZStack(alignment: .top) {
                        Image(template.templateCoverImagePath)
                            .resizable()
                            .frame(height: 220 * heightRatio)
                            .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio, style: .continuous))
                    }
                    Spacer()
                    HStack {
                        Text(template.templateName)
                            .font(
                                Font.custom("Fredoka", size: 24 * heightRatio)
                                    .weight(.semibold)
                            )
                            .foregroundColor(Color("FSBlack"))
                        Spacer()
                        Text("3 m")
                            .font(Font.custom("Fredoka", size: 14 * heightRatio))
                            .foregroundColor(Color("FSGrey"))
                    }
                    .padding(12 * heightRatio)
                    Spacer().frame(height: 19 * heightRatio)
                }
            )
            .onTapGesture {
                onTap()
            }
    }
}
