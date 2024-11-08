//
//  DraggablePage.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 11/10/24.
//

import Foundation
import UniformTypeIdentifiers
import CoreTransferable

struct DraggablePage: Codable, Identifiable, Equatable {
    
    var id: UUID?
    var order: Int
    var picturePath: String
    
    static func == (lhs: DraggablePage, rhs: DraggablePage) -> Bool {
        lhs.id == rhs.id
    }
    
    // debug function
    static func loadDummyData() -> [DraggablePage] {
        return [
            DraggablePage(id: UUID(uuidString: "819f2cc6-345d-4bfa-b081-2b0d4afc53ac") ?? UUID(), order: 0, picturePath: "DummyImage"),
            DraggablePage(id: UUID(), order: 1, picturePath: "DummyImage2"),
            DraggablePage(id: UUID(), order: 2, picturePath: "DummyImage3"),
        ]
    }
    
    static func loadEmptyArray(storyPageCount: Int) -> [(DraggablePage, Bool)] {
        var emptryArray: [(DraggablePage, Bool)] = []
        var counter = 0
        for _ in 0..<storyPageCount {
            emptryArray.append((DraggablePage(id: nil, order: counter, picturePath: ""), false))
            counter += 1
        }
        return emptryArray
    }
    
    private static func getPage(_ page: PageEntity, order: Int) -> DraggablePage {
        if let picture = page.pagePicture.first {
            return DraggablePage(id: page.pageId,
                                 order: order,
                                              picturePath: picture.componentContent
                                             )
        } else if let video = page.pageVideo.first {
            return DraggablePage(id: page.pageId,
                                 order: order,
                                              picturePath: video.componentContent
                                             )
        } else {
            return DraggablePage(id: page.pageId,
                                 order: order,
                                              picturePath: ""
                                             )
        }
    }
    
    public static func fetchIntroductionPages(story: StoryEntity) -> [DraggablePage] {
        var draggedPages = [DraggablePage]()
        var counter = 0
        for page in story.pages {
//            guard page.pageType != "Opening" && page.pageType != "Closing" else { continue } // not include the first and last page
            guard page.pageType == "Introduction" else { continue }
            
            draggedPages.append(getPage(page, order: counter))
            counter += 1
            
        }
        return draggedPages
    }
    
    public static func fetchDraggedPage(story: StoryEntity) -> [DraggablePage] {
        var draggedPages = [DraggablePage]()
        var counter = 0
        for page in story.pages {
//            guard page.pageType != "Opening" && page.pageType != "Closing" else { continue } // not include the first and last page
            guard page.pageType == "Instruction" else { continue }
            
            draggedPages.append(getPage(page, order: counter))
            counter += 1
            
        }
        return draggedPages
    }
}

extension DraggablePage: Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .draggablePage)
    }
}

extension UTType {
    static var draggablePage = UTType(exportedAs: "\(Project.bundleIdentifier).draggablePage")
}


