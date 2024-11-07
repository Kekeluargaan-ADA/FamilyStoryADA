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
    @State private var wiggleStates: [Int: Bool] = [:]
//    @State private var wiggleDegree: [Int: Double] = [:]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: flexibleRow, spacing: 12) {
                ForEach(Array(viewModel.draggedPages.enumerated()), id: \.offset) { index, value in
                    MiniGameOptionCardView(image: viewModel.displayImage(fileName: value.picturePath), isOption: value.id != nil)
//                        .rotationEffect(.degrees(wiggleStates[index] == true ? wiggleDegree[index] ?? 5 : 0))
//                        .animation(wiggleStates[index] == true ? Animation.linear(duration: 0.5).repeatCount(2, autoreverses: true) : .default, value: wiggleStates[index])
                        .rotationEffect(.degrees(wiggleStates[index] == true ? 5 : 0))
                                                .animation(
                                                    wiggleStates[index] == true
                                                    ? Animation.linear(duration: 0.25).repeatForever( autoreverses: true)
                                                    : .default,
                                                    value: wiggleStates[index]
                                                )
                        .onTapGesture {
                            if value.id != nil, viewModel.correctAnswer[viewModel.currentlyCheckedIndex].id == value.id {
                                viewModel.draggedPages[index].id = nil
                                viewModel.draggedPages[index].picturePath = ""
                                viewModel.currentlyCheckedIndex += 1
                            } else if value.id != nil {
                                withAnimation {
                                    wiggleStates[index] = true
//                                    wiggleDegree[index] = 5
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        wiggleStates[index] = false
                                    }
                                }
                            }
                        }
                    //TODO: Fix left and right toggle
//                        .onChange(of: wiggleDegree[index]) { value in
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                withAnimation {
//                                    if let state = wiggleStates[index], state {
//                                        if wiggleDegree[index] == 5 {
//                                            wiggleDegree[index] = -5
//                                        } else {
//                                            wiggleDegree[index] = 5
//                                        }
//                                    }
//                                }
//                            }
//                            
//                        }
                }
            }
        }
    }
}


#Preview {
    MiniGameOptionArrayView()
}
