//
//  DraggablePageCustomizationSelectionView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import SwiftUI

struct DraggablePageCustomizationSelectionView: View {
    @EnvironmentObject var viewModel: PageCustomizationViewModel
    @Binding var draggedPages: [DraggablePage]
    
    @State private var targetedIndex: Int? = nil
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                DroppedPageTargetCustomizationView(isSelected: targetedIndex == -1)
                    .dropDestination(for: DraggablePage.self) { droppedPage, location in
                        if let page = droppedPage.first {
                            viewModel.movePage(page, toIndex: -1)
                            return true
                        }
                        return false
                        
                    } isTargeted: { isTargeted in
                        if isTargeted {
                            targetedIndex = -1
                        } else if targetedIndex == -1 {
                            targetedIndex = nil
                        }
                    }
                ForEach(Array(draggedPages.enumerated()), id: \.offset) { index, page in
                    if let image = viewModel.loadImageFromDiskWith(fileName: page.picturePath) {
                        DraggedPageView(imagePath: image,
                                        order: index+1,
                                        isSelected: viewModel.selectedPage?.pageId == page.id
                        )
                        .draggable(page)
                        .onTapGesture {
                            viewModel.selectPage(page: page)
                        }
                    } else if page.picturePath != "" {
                        DraggedPageView(imagePath: UIImage(imageLiteralResourceName: page.picturePath),
                                        order: index+1,
                                        isSelected: viewModel.selectedPage?.pageId == page.id
                        )
                        .draggable(page)
                        .onTapGesture {
                            viewModel.selectPage(page: page)
                        }
                    } else {
                        DraggedPageView(order: index+1,
                                        isSelected: viewModel.selectedPage?.pageId == page.id
                        )
                        .draggable(page)
                        .onTapGesture {
                            viewModel.selectPage(page: page)
                        }
                    }
                        
                    DroppedPageTargetCustomizationView(isSelected: targetedIndex == index)
                        .dropDestination(for: DraggablePage.self) { droppedPage, location in
                            
                            if let page = droppedPage.first {
                                viewModel.movePage(page, toIndex: index)
                                return true
                            }
                            return false
                        } isTargeted: { isTargeted in
                            if isTargeted {
                                targetedIndex = index
                            } else if targetedIndex == index {
                                targetedIndex = nil
                            }
                        }
                }
                
                // add button only appear if visible page is below 10
                if  viewModel.isAddButtonAppeared() {
                    Button(action: {
                        viewModel.addNewBlankPage()
                    }, label: {
                        AddNewPageButtonView()
                    })
                }
            }
        }
    }
}

//#Preview {
//    DraggablePageCustomizationSelectionView(draggedPages: DraggablePage.loadDummyData(), selectedStoryId: UUID(uuidString: "819f2cc6-345d-4bfa-b081-2b0d4afc53ac"))
//}
