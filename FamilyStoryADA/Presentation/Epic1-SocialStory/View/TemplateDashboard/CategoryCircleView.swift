//
//  CategoryCircleView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//

import SwiftUI

struct CategoryCircleView: View {
    let heightRatio: CGFloat
    let widthRatio: CGFloat
    let buttonImage: String
    let text: String
    let onTap: () -> Void
    
    var body: some View {
        VStack {
            Button(action: {
                onTap()
            }) {
                Circle()
                    .foregroundStyle(Color("FSSecondaryBlue4"))
                    .frame(height: 64 * heightRatio)
                    .overlay(
                        Image(systemName: buttonImage)
                            .foregroundStyle(Color("FSBlue9"))
                            .font(.system(size: 26 * heightRatio))
                            .bold()
                    )
            }
            .buttonStyle(.plain)
            Spacer().frame(height: 8 * heightRatio)
            Text(text)
        }
        .padding(20 * heightRatio)
    }
}


#Preview {
    CategoryCircleView(heightRatio: 1, widthRatio: 1, buttonImage: "photo.fill", text: "Text ", onTap: {})
}
