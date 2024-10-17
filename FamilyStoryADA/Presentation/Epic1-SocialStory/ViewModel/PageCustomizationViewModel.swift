//
//  PageCustomizationViewModel.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import Foundation

class PageCustomizationViewModel: ObservableObject {
    @Published var story: StoryEntity
    @Published var draggedPage: [DraggablePage] = []
    
    init (story: StoryEntity) {
        self.story = story
        
        fetchDraggedPage()
    }
    
    //refresh dragged page
    private func fetchDraggedPage() {
        self.draggedPage = [DraggablePage]()
        for page in story.pages {
            draggedPage.append(DraggablePage(id: page.pageId,
                                             picturePath: page.pagePicture.first?.componentContent ?? ""
                                            ))
        }
    }
}
