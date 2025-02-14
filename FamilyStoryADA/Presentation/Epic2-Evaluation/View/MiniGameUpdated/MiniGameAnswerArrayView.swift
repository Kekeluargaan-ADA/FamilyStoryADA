//
//  MiniGameAnswerArrayView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 06/11/24.
//

import SwiftUI

struct MiniGameAnswerArrayView: View {
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    @Binding var correctAnswers: [DraggablePage]
    @Binding var currentlyCheckedIndex: Int
    let imageProvider: (String) -> UIImage?
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20 * widthRatio) {
                ForEach(Array(correctAnswers.enumerated()), id: \.offset) { index, value in
                    MiniGameAnswerCardView(order: index + 1, imagePath: imageProvider(value.picturePath), answerCardStatus: getCardStatus(index: index), widthRatio: widthRatio, heightRatio: heightRatio)
                }
            }
            .padding(.horizontal, 20 * widthRatio)
        }
        .scrollIndicators(.hidden)
    }
    
    func getCardStatus(index: Int) -> AnswerCardStatus {
        if currentlyCheckedIndex == index {
            return .checked
        } else if index < currentlyCheckedIndex {
            return .revealed
        } else {
            return .blank
        }
    }
}

//#Preview {
//    MiniGameAnswerArrayView(widthRatio: 1, heightRatio: 1)
//}
