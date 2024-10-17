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
    @Published var selectedPage: PageEntity?
    
    var pageUsecase: PageUsecase
    var storyUsecase: StoryUsecase
    
    init(story: StoryEntity) {
        self.story = story
        self.pageUsecase = ImplementedPageUsecase()
        self.storyUsecase = ImplementedStoryUsecase()
        
        if let firstPage = story.pages.first {
            self.selectedPage = firstPage
        }
        
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
            story.pages.append(newPage)
            if storyUsecase.updateStory(story: story) {
                fetchDraggedPage()
                
                if selectedPage == nil {
                    if let firstPage = story.pages.first {
                        self.selectedPage = firstPage
                    }
                }
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
        
        for draggedPage in draggedPages {
            if let matchingPage = story.pages.first(where: { $0.pageId == draggedPage.id }) {
                reorderedPages.append(matchingPage)
            }
        }
        
        story.pages = reorderedPages
        
        if storyUsecase.updateStory(story: story) {
            fetchDraggedPage()
        }
    }
    
    // when user select page
    public func selectPage(page: DraggablePage) {
        if let page = story.pages.first(where: {$0.pageId == page.id}) {
            self.selectedPage = page
        }
    }
    
    // when user want to delete page
    public func deletePage() {
        if let page = selectedPage {
            if let storyIndex = story.pages.firstIndex(where: {page.pageId == $0.pageId}) {
                //remove page swiftdata
                guard pageUsecase.removePage(pageId: page.pageId) else { return }
                
                //remove page in story entity
                story.pages.removeAll(where: {$0.pageId == page.pageId})
                //update pageid in story swiftdata, by updating
                if storyUsecase.updateStory(story: story) {
                    //update draggedPage
                    fetchDraggedPage()
                    guard !story.pages.isEmpty else {
                        selectedPage = nil
                        return
                    }
                    if storyIndex > 0 {
                        selectedPage = story.pages[storyIndex - 1]
                    } else {
                        selectedPage = story.pages[storyIndex]
                    }
                }
            }
            
            
        }
    }
}
