//
//  DraggablePageCustomizationSelectionView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import SwiftUI

struct DraggablePageCustomizationSelectionView: View {
    //    var viewModel: PageCustomizationViewModel
    @State var draggedPages: [DraggablePage]
    var selectedStoryId: UUID?
    
    @State private var targetedIndex: Int? = nil
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                DroppedPageTargetCustomizationView(isSelected: targetedIndex == -1)
                    .dropDestination(for: DraggablePage.self) { droppedPage, location in
                        if let page = droppedPage.first {
                            movePage(page, toIndex: -1)
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
                    DraggedPageView(imagePath: page.picturePath,
                                    order: index+1,
                                    isSelected: selectedStoryId == page.id
                    )
                    .draggable(page)
                    DroppedPageTargetCustomizationView(isSelected: targetedIndex == index)
                        .dropDestination(for: DraggablePage.self) { droppedPage, location in
                            
                            if let page = droppedPage.first {
                                print("Moved")
                                movePage(page, toIndex: index)
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
            }
        }
    }
    
    // move page
    func movePage(_ page: DraggablePage, toIndex newIndex: Int) {
        var nextIndex = newIndex
            if let currentIndex = draggedPages.firstIndex(where: { $0.id == page.id }) {
                if currentIndex == newIndex {return}
                if currentIndex > newIndex {nextIndex += 1}
                draggedPages.remove(at: currentIndex)
                let validIndex = min(max(nextIndex, 0), draggedPages.count)
                draggedPages.insert(page, at: validIndex)
            }
        }
}

#Preview {
    DraggablePageCustomizationSelectionView(draggedPages: DraggablePage.loadDummyData(), selectedStoryId: UUID(uuidString: "819f2cc6-345d-4bfa-b081-2b0d4afc53ac"))
}
