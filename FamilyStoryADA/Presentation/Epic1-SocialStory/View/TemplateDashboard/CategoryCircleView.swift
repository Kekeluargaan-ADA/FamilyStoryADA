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
            ButtonCircle(heightRatio: heightRatio, buttonImage: buttonImage, onTap: onTap)
            Spacer().frame(height: 8 * heightRatio)
            Text(text)
        }
        .padding(20 * heightRatio)
    }
}


#Preview {
    CategoryCircleView(heightRatio: 1, widthRatio: 1, buttonImage: "photo.fill", text: "Text ", onTap: {})
}
