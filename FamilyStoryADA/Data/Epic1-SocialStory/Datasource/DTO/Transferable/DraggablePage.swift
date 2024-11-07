//
//  DraggablePage.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 11/10/24.
//

import Foundation
import UniformTypeIdentifiers
import CoreTransferable

struct DraggablePage: Codable {
    
    var id: UUID?
    var picturePath: String
    
    
    // debug function
    static func loadDummyData() -> [DraggablePage] {
        return [
            DraggablePage(id: UUID(uuidString: "819f2cc6-345d-4bfa-b081-2b0d4afc53ac") ?? UUID(), picturePath: "DummyImage"),
            DraggablePage(id: UUID(), picturePath: "DummyImage2"),
            DraggablePage(id: UUID(), picturePath: "DummyImage3"),
        ]
    }
    
    static func loadEmptyArray(storyPageCount: Int) -> [(DraggablePage, Bool)] {
        var emptryArray: [(DraggablePage, Bool)] = []
        for _ in 0..<storyPageCount {
            emptryArray.append((DraggablePage(id: nil, picturePath: ""), false))
        }
        return emptryArray
    }
    
    public static func fetchDraggedPage(story: StoryEntity) -> [DraggablePage] {
        var draggedPages = [DraggablePage]()
        for page in story.pages {
//            guard page.pageType != "Opening" && page.pageType != "Closing" else { continue } // not include the first and last page
            guard page.pageType == "Instruction" else { continue }
            if let picture = page.pagePicture.first {
                draggedPages.append(DraggablePage(id: page.pageId,
                                                  picturePath: picture.componentContent
                                                 ))
            } else if let video = page.pageVideo.first {
                draggedPages.append(DraggablePage(id: page.pageId,
                                                  picturePath: video.componentContent
                                                 ))
            } else {
                draggedPages.append(DraggablePage(id: page.pageId,
                                                  picturePath: ""
                                                 ))
            }
            
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


