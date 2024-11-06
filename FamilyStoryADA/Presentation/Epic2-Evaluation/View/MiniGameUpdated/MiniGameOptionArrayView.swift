//
//  MiniGameOptionArrayView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 06/11/24.
//

import SwiftUI

struct MiniGameOptionArrayView: View {
    @EnvironmentObject var viewModel: MiniGameViewModel
    private let flexibleRow = [
        GridItem(.fixed(191)),
        GridItem(.fixed(191))
    ]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: flexibleRow, spacing: 12) {
                ForEach(Array(viewModel.draggedPages.enumerated()), id: \.offset) { index, value in
                    MiniGamOptionCardView(image: viewModel.displayImage(fileName: value.picturePath), isOption: value.id != nil)
                        .onTapGesture {
                            viewModel.draggedPages[index].id = nil
                            viewModel.draggedPages[index].picturePath = ""
                        }
                }
            }
        }
    }
}

#Preview {
    MiniGameOptionArrayView()
}
