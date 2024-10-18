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
            Spacer(minLength: 47)
            PlayStoryNavigationView(heightRatio: 1, buttonColor: .yellow, onTapHomeButton: {}, onTapAudioButton: {})
                .padding(.horizontal, 46)
            Spacer(minLength: 60)
            Text("Urutkan kartu di bawah sesuai dengan urutan yang benar.")
                .font(.system(size: 32, weight: .semibold))
                .foregroundStyle(.black)
            Spacer(minLength: 50)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(viewModel.droppableBox.enumerated()), id: \.offset) { index, page in
                        DroppableBoxView(order: index+1, imagePath: page.picturePath)
                            .dropDestination(for: DraggablePage.self) { droppedPage, location in
                                
                                guard page.id == nil else { return false }
                                
                                for page in droppedPage {
                                    guard !viewModel.droppableBox.contains(where: {$0.id == page.id}) && viewModel.droppableBox[index].picturePath == "" else { return false }
                                    
                                    viewModel.draggedPages.removeAll(where: { $0.id == page.id })
                                    
                                    viewModel.droppableBox[index] = page
                                }
                                
                                if viewModel.isReadyForChecking() {
                                    viewModel.checkAnswer()
                                    
                                }
                                return true
                            } isTargeted: { isTargeted in
                                
                            }
                            .onTapGesture {
                                if page.id != nil {
                                    viewModel.draggedPages.append(page)
                                    viewModel.droppableBox[index] = DraggablePage(id: nil, picturePath: "")
                                }
                            }
                    }
                }
            }
            .padding(.horizontal, 49)
            Spacer(minLength: 53)
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color("FSWhite"))
                    .shadow(radius: 4, x: 0, y: 4)
                ScrollView(.horizontal) {
                    HStack (spacing: 15) {
                        ForEach(viewModel.draggedPages, id: \.id) { page in
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundStyle(Color("FSYellow2"))
                                    .shadow(radius: 4, x: 0, y: 4)
                                Image(page.picturePath)
                                    .resizable()
                                    .scaledToFit()
                            }
                            .frame(width: 123, height: 123)
                            .draggable(page)
                        }
                    }
                    .padding(.horizontal, 49)
                    .padding(.vertical, 42)
                }
            }
            .frame(width: 913, height: 207)
            Spacer()
        }
        .ignoresSafeArea()
        .background(Color("FSYellow1"))
    }
}

//#Preview {
//    MiniQuizView()
//}
