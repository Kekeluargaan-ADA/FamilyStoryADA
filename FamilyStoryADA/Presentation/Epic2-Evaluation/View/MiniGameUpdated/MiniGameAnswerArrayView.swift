//
//  MiniGameAnswerArrayView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 06/11/24.
//

import SwiftUI

struct MiniGameAnswerArrayView: View {
    @EnvironmentObject var viewModel: MiniGameViewModel
    var body: some View {
        ScrollView(.horizontal) {
            ForEach(viewModel.correctAnswer, id: \.id) { value in
//                MiniGamOptionCardView(image: viewModel.displayImage(fileName: value.picturePath), isOption: value.id != nil)
            }
        }
    }
}

#Preview {
    MiniGameAnswerArrayView()
}
