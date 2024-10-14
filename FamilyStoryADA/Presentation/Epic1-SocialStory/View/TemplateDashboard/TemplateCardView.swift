//
//  TenplateCardView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//
import SwiftUI

struct TemplateCardView: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(.gray)
            .frame(width: 354, height: 280)
            .cornerRadius(12)
            .overlay(
                VStack(alignment: .leading) {
                    ZStack(alignment: .top) {
                        UnevenRoundedRectangle(cornerRadii: .init(topLeading: 12, topTrailing: 12))
                            .frame(height: 220)
                            .foregroundStyle(.black)
                    }
                    Spacer()
                    HStack {
                        Text("Judul Story")
                            .bold()
                            .font(.system(size: 24))
                        Spacer()
                        Text("3 mins")
                            .font(.system(size: 16))
                    }
                    .padding(12)
                    Spacer().frame(height: 19)
                }
            )
    }
}

#Preview {
    TemplateCardView()
}
