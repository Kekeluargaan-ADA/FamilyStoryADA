//
//  PageCustomizationViewModel.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import Foundation

class PageCustomizationViewModel: ObservableObject {
    @Published var story: StoryEntity
    @Published var draggedPages: [DraggablePage] = []
    
    var pageUsecase: PageUsecase
    var storyUsecase: StoryUsecase
    
    init(story: StoryEntity) {
        self.story = story
        self.pageUsecase = ImplementedPageUsecase()
        self.storyUsecase = ImplementedStoryUsecase()
        
        fetchDraggedPage()
    }
    
    //refresh dragged page
    private func fetchDraggedPage() {
        self.draggedPages = [DraggablePage]()
        for page in story.pages {
            draggedPages.append(DraggablePage(id: page.pageId,
                                             picturePath: page.pagePicture.first?.componentContent ?? ""
                                            ))
        }
    }
    
    //make new blank page
    public func addNewBlankPage() {
        let newPage = PageEntity(pageId: UUID(),
                                 pageText: [],
                                 pagePicture: [],
                                 pageVideo: [],
                                 pageSoundPath: ""
        )
        
        if pageUsecase.addPage(page: newPage) == newPage.pageId {
            if storyUsecase.updateStory(story: story) {
                story.pages.append(newPage)
                fetchDraggedPage()
            }
        }
    }
    
    // move page
    public func movePage(_ page: DraggablePage, toIndex newIndex: Int) {
        var nextIndex = newIndex
        if let currentIndex = draggedPages.firstIndex(where: { $0.id == page.id }) {
            if currentIndex == newIndex {return}
            if currentIndex > newIndex {nextIndex += 1}
            self.draggedPages.remove(at: currentIndex)
            let validIndex = min(max(nextIndex, 0), draggedPages.count)
            draggedPages.insert(page, at: validIndex)
            
            reorderStoryPages()
        }
    }
    
    private func reorderStoryPages() {
        var reorderedPages = [PageEntity]()
        
        // Loop through the draggedPages and find the matching PageEntity by pageId in story.pages
        for draggedPage in draggedPages {
            if let matchingPage = story.pages.first(where: { $0.pageId == draggedPage.id }) {
                reorderedPages.append(matchingPage)
            }
        }
        
        // Update the story.pages to reflect the new order
        story.pages = reorderedPages
        
        // Optionally, persist the updated story to ensure the new order is saved
        if storyUsecase.updateStory(story: story) {
            fetchDraggedPage()  // Refresh draggedPages to ensure consistency
        }
    }
}
