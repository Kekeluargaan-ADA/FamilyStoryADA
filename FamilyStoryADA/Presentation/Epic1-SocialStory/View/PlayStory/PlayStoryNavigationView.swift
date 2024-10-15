//
//  PlayStoryNavigationView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//

import SwiftUI

struct PlayStoryNavigationView: View {
    let heightRatio: CGFloat

    var body: some View {
        HStack {
            Circle()
                .foregroundStyle(.gray)
                .frame(height: 64 * heightRatio)
                .overlay(
                    Image(systemName: "house")
                        .font(.system(size: 26 * heightRatio))
                )
            Spacer()
            Text("Title")
                .font(.system(size: 26 * heightRatio))
                .fontWeight(.medium)
            Spacer()
            Circle()
                .foregroundStyle(.gray)
                .frame(height: 64 * heightRatio)
                .overlay(
                    Image(systemName: "speaker.wave.2")
                        .font(.system(size: 26 * heightRatio))
                )
        }
    }
}

#Preview {
    PlayStoryNavigationView(heightRatio: 1.0)
}
