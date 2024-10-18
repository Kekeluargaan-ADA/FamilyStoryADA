//
//  MiniQuizView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 11/10/24.
//

import SwiftUI

struct MiniQuizView: View {
    @StateObject var viewModel: MiniQuizViewModel
    
    init(story: StoryEntity) {
        _viewModel = StateObject(wrappedValue: MiniQuizViewModel(story: story))
    }
    
    var body: some View {
        VStack {
            PlayStoryNavigationView(heightRatio: 1, onTapHomeButton: {}, onTapAudioButton: {})
            Text("Urutkan kartu di bawah sesuai dengan urutan yang benar.")
                .font(.system(size: 32))
                .foregroundStyle(.black)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(viewModel.droppableBox.enumerated()), id: \.offset) { index, page in
                        DroppableBoxView(order: index+1, imagePath: page.picturePath)
                            .dropDestination(for: DraggablePage.self) { droppedPage, location in
                                
                                for page in droppedPage {
                                    guard !viewModel.droppableBox.contains(where: {$0.id == page.id}) && viewModel.droppableBox[index].picturePath == "" else { return false }
                                    
                                    viewModel.draggedPages.removeAll(where: { $0.id == page.id })
                                    
                                    viewModel.droppableBox[index] = page
                                }
                                return true
                            } isTargeted: { isTargeted in
                                
                            }
                    }
                }
            }
            
            HStack {
                ForEach(viewModel.draggedPages, id: \.id) { page in
                    Image(page.picturePath)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 123, height: 123)
                        .draggable(page)
                }
            }
            Spacer()
            
        }
    }
}

//#Preview {
//    MiniQuizView()
//}
