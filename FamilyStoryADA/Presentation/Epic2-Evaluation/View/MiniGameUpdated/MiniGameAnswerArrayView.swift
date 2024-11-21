//
//  MiniGameAnswerArrayView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 06/11/24.
//

import SwiftUI

struct MiniGameAnswerArrayView: View {
    @EnvironmentObject var viewModel: MiniGameViewModel
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20 * widthRatio) {
                ForEach(Array(viewModel.correctAnswer.enumerated()), id: \.offset) { index, value in
                    MiniGameAnswerCardView(order: index + 1, imagePath: viewModel.displayImage(fileName: value.picturePath), answerCardStatus: getCardStatus(index: index), widthRatio: widthRatio, heightRatio: heightRatio)
                }
            }
            .padding(.horizontal, 20 * widthRatio)
        }
        .scrollIndicators(.hidden)
    }
    
    func getCardStatus(index: Int) -> AnswerCardStatus {
        if viewModel.currentlyCheckedIndex == index {
            return .checked
        } else if index < viewModel.currentlyCheckedIndex {
            return .revealed
        } else {
            return .blank
        }
    }
}

#Preview {
    MiniGameAnswerArrayView(widthRatio: 1, heightRatio: 1)
}
