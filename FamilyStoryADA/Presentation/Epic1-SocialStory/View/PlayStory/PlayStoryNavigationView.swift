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
    let titleOverlayReversed: Bool

    var body: some View {
        HStack(spacing: 346 * widthRatio) {
            Button(action: {
                onTapHomeButton()
            }, label: {
                ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "house", buttonColor: buttonColor, size: 79)
            })
            ZStack {
                RoundedRectangle(cornerRadius: 28 * heightRatio)
                    .foregroundStyle(Color(titleOverlayReversed ? "FSBlueBorder2" : "FSWhite"))
                    .frame(height: 53 * heightRatio)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28 * heightRatio)
                            .stroke(Color(titleOverlayReversed ? "FSWhite" : "FSBlueBorder1"), lineWidth: 4)
                    )
                Text(title)
                    .font(Font.custom("Fredoka", size: 24 * heightRatio, relativeTo: .title2))
                    .fontWeight(.medium)
                    .foregroundStyle(Color(titleOverlayReversed ? .fsWhite : .fsBlueBorder2))
            }
            .frame(height: 53 * heightRatio)
            if showAudioButton {
                Button(action: {
                    onTapAudioButton()
                }, label: {
                    ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "speaker.wave.2", buttonColor: buttonColor, size: 79)
                })
            } else {
                Spacer()
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
        showAudioButton: true, // Change to 'false' to hide the audio button
        titleOverlayReversed: true
    )
}
