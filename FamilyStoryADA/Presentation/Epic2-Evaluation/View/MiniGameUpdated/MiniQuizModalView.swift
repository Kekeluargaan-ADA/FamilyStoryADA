//
//  MiniQuizModal.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 19/10/24.
//

import SwiftUI

struct MiniQuizModalView: View {
//    @EnvironmentObject var viewModel: MiniQuizViewModel
    @EnvironmentObject var viewModel: MiniGameViewModel
    @Environment(\.dismiss) var dismiss
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        VStack {
            Image("result-quiz-v01")
                .resizable()
                .scaledToFill()
                .frame(width: 541 * widthRatio, height: 304 * heightRatio)
                .padding(.bottom, 8 * heightRatio)
            Text("Kamu Keren!")
                .font(Font.custom("Fredoka", size: 40 * heightRatio, relativeTo: .largeTitle))
                .fontWeight(.semibold)
                .foregroundStyle(Color("FSBlack"))
                .padding(.bottom, 23 * heightRatio)
            Text("Apakah kamu ingin bermain susun kartu lagi?")
                .font(Font.custom("Fredoka", size: 24 * heightRatio, relativeTo: .title2))
                .fontWeight(.medium)
                .foregroundStyle(Color("FSBlack"))
                .padding(.bottom, 24 * heightRatio)
            HStack(spacing: 20 * widthRatio) {
                Button(action: {
                    viewModel.isDismissed = true
                    dismiss()
                }, label: {
                    ButtonElips(text: "Tidak", buttonPreset: .yellow, buttonStyle: .secondary, widthRatio: widthRatio, heightRatio: heightRatio)
                })
                Button(action: {
//                    viewModel.resetQuiz()
                    viewModel.resetGame()
                }, label: {
                    ButtonElips(text: "Main Lagi", buttonPreset: .yellow, buttonStyle: .primary, widthRatio: widthRatio, heightRatio: heightRatio)
                })
            }
        }
        .padding(.horizontal, 93 * widthRatio)
        .padding(.top, 24 * heightRatio)
        .padding(.bottom, 20 * heightRatio)
//        .background(Color("FSYellow1"))
    }
}

#Preview {
    MiniQuizModalView(widthRatio: 1, heightRatio: 1)
}
