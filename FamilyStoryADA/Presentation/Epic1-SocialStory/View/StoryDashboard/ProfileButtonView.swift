//
//  ProfileButtonView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import SwiftUI

struct ProfileButtonView: View {
    var imageName: String
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 60, height: 60)
                .foregroundStyle(Color("FSSecondaryBlue4"))
            if imageName != "" {
                Image(imageName)
                    .resizable()
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(Color("FSBlue9"))
            }
        }
    }
}

#Preview {
    ProfileButtonView(imageName: "DummyImage")
}
