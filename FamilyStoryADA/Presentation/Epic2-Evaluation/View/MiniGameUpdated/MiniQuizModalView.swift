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
    var body: some View {
        VStack {
            Image("result-quiz-v01")
                .resizable()
                .scaledToFill()
                .frame(width: 541, height: 304)
                .padding(.bottom, 8)
            Text("Kamu Keren!")
                .font(Font.custom("Fredoka", size: 40, relativeTo: .largeTitle))
                .fontWeight(.semibold)
                .foregroundStyle(Color("FSBlack"))
                .padding(.bottom, 23)
            Text("Apakah kamu ingin bermain susun kartu lagi?")
                .font(Font.custom("Fredoka", size: 24, relativeTo: .title2))
                .fontWeight(.medium)
                .foregroundStyle(Color("FSBlack"))
                .padding(.bottom, 24)
            HStack(spacing: 20) {
                Button(action: {
                    viewModel.isDismissed = true
                    dismiss()
                }, label: {
                    ButtonElips(text: "Tidak", buttonPreset: .yellow, buttonStyle: .secondary)
                })
                Button(action: {
//                    viewModel.resetQuiz()
                    viewModel.resetGame()
                }, label: {
                    ButtonElips(text: "Main Lagi", buttonPreset: .yellow, buttonStyle: .primary)
                })
            }
        }
        .padding(.horizontal, 93)
        .padding(.top, 24)
        .padding(.bottom, 20)
//        .background(Color("FSYellow1"))
    }
}

#Preview {
    MiniQuizModalView()
}
