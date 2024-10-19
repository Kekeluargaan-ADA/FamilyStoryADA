//
//  DroppableArrayView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 19/10/24.
//

import SwiftUI

struct DroppableArrayView: View {
    @EnvironmentObject var viewModel: MiniQuizViewModel
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(Array(viewModel.droppableBox.enumerated()), id: \.offset) { index, page in
                    DroppableBoxView(order: index+1, imagePath: page.0.picturePath)
                        .dropDestination(for: DraggablePage.self) { droppedPages, location in
                            
                            guard page.0.id == nil else { return false }
                            
                            for droppedPage in droppedPages {
                                guard !viewModel.droppableBox.contains(where: {$0.0.id == droppedPage.id}) && viewModel.droppableBox[index].0.picturePath == "" else { return false }
                                
                                viewModel.draggedPages.removeAll(where: { $0.id == droppedPage.id })
                                
                                viewModel.droppableBox[index].0 = droppedPage
                            }
                            
                            if viewModel.isReadyForChecking() {
                                if viewModel.checkAnswer() {
                                    viewModel.isAllCorrect = true
                                }
                                
                            }
                            return true
                        } isTargeted: { isTargeted in
                            
                        }
                        .onTapGesture {
                            if page.0.id != nil && !page.1 {
                                viewModel.draggedPages.append(page.0)
                                viewModel.droppableBox[index] = (DraggablePage(id: nil, picturePath: ""), false)
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    DroppableArrayView()
}
