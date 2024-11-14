//
//  TenplateCardView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//
import SwiftUI

struct TemplateCardView: View {
    var template: TemplateEntity
    var onTap: () -> Void

    var body: some View {
        Rectangle()
            .foregroundStyle(Color("FSWhite"))
            .frame(width: 354, height: 280)
            .cornerRadius(12)
            .shadow(radius: 2, y: 4)
            .overlay(
                VStack(alignment: .leading) {
                    ZStack(alignment: .top) {
                        Image(template.templateCoverImagePath)
                            .resizable()
                            .frame(height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    Spacer()
                    HStack {
                        Text(template.templateName)
                            .font(
                                Font.custom("Fredoka", size: 24)
                                    .weight(.semibold)
                            )
                            .foregroundColor(Color("FSBlack"))
                        Spacer()
                        Text("3 m")
                            .font(Font.custom("Fredoka", size: 14))
                            .foregroundColor(Color("FSGrey"))
                    }
                    .padding(12)
                    Spacer().frame(height: 19)
                }
            )
            .onTapGesture {
                onTap()
            }
    }
}
