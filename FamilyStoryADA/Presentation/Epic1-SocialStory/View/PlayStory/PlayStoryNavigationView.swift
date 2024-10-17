//
//  PlayStoryNavigationView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//

import SwiftUI

struct PlayStoryNavigationView: View {
    let heightRatio: CGFloat
    let onTap: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                
            }, label: {
                ButtonCircle(heightRatio: heightRatio, buttonImage: "house")
            })
            Spacer()
            Text("Title")
                .font(.system(size: 26 * heightRatio))
                .fontWeight(.medium)
            Spacer()
            Button(action: {
                
            }, label: {
                ButtonCircle(heightRatio: heightRatio, buttonImage: "speaker.wave.2")
            })
        }
    }
}

#Preview {
    PlayStoryNavigationView(heightRatio: 1, onTap: {})
}
