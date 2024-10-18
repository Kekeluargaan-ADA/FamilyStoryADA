//
//  ExampleComponent.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 24/09/24.
//

import SwiftUI

struct ButtonCircle: View {
    let heightRatio: CGFloat
    let buttonImage: String
    
    var body: some View {
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
}

#Preview {
    ButtonCircle(heightRatio: 1.0, buttonImage: "house")
}
