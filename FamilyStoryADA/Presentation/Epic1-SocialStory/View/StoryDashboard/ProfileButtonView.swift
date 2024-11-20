//
//  ProfileButtonView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import SwiftUI

struct ProfileButtonView: View {
    var imageName: String
    
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 60 * widthRatio, height: 60 * heightRatio)
                .foregroundStyle(Color("FSSecondaryBlue4"))
            if imageName != "" {
                Image(imageName)
                    .resizable()
                    .frame(width: 55 * widthRatio, height: 55 * heightRatio)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person")
                    .font(.system(size: 26 * heightRatio, weight: .bold))
                    .foregroundStyle(Color("FSBlue9"))
            }
        }
    }
}

#Preview {
    ProfileButtonView(imageName: "DummyImage", widthRatio: 1, heightRatio: 1)
}
