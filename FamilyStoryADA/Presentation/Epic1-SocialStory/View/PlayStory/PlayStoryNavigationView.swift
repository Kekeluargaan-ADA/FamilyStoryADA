//
//  PlayStoryNavigationView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//

import SwiftUI

struct PlayStoryNavigationView: View {
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    let title: String
    let buttonColor: ButtonPreset
    let onTapHomeButton: () -> Void
    let onTapAudioButton: () -> Void
    let showAudioButton: Bool

    var body: some View {
        HStack {
            Button(action: {
                onTapHomeButton()
            }, label: {
                ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "house", buttonColor: buttonColor)
            })
            Spacer()
            Text(title)
                .font(Font.custom("Fredoka", size: 24 * heightRatio, relativeTo: .title2))
                .fontWeight(.bold)
                .foregroundStyle(Color("FSBlack"))
            Spacer()
            if showAudioButton {
                Button(action: {
                    onTapAudioButton()
                }, label: {
                    ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "speaker.wave.2", buttonColor: buttonColor)
                })
            }
        }
    }
}

#Preview {
    PlayStoryNavigationView(
        widthRatio: 1.0,
        heightRatio: 1,
        title: "Title",
        buttonColor: .blue,
        onTapHomeButton: {},
        onTapAudioButton: {},
        showAudioButton: true // Change to 'false' to hide the audio button
    )
}
