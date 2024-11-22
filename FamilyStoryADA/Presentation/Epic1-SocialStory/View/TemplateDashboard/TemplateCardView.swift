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
            .shadow(color: Color(.fsBlack).opacity(0.1), radius: 4, y: 4 * heightRatio)
            .overlay(
                VStack(alignment: .leading) {
                    ZStack(alignment: .top) {
                        Image(template.templateCoverImagePath)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 354 * widthRatio, height: 220 * heightRatio)
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
                        Text("\(template.templateLength, specifier: "%.0f") m")
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
