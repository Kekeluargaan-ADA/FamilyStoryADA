//
//  DraggablePage.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 11/10/24.
//

import Foundation
import UIKit

class MiniGamePage: Codable, Identifiable, Equatable {
    
    var id: UUID?
    var order: Int
    var picturePath: String
    private var pictureData: Data? // Store UIImage as Data for Codable conformance
    var picture: UIImage {
        get {
            if let data = pictureData {
                return UIImage(data: data) ?? UIImage()
            }
            return UIImage()
        }
        set {
            pictureData = newValue.pngData()
        }
    }
    
    init(id: UUID? = nil, order: Int, picturePath: String, picture: UIImage) {
        self.id = id
        self.order = order
        self.picturePath = picturePath
        self.picture = picture
        self.pictureData = picture.pngData()
    }
    
    static func == (lhs: MiniGamePage, rhs: MiniGamePage) -> Bool {
        lhs.id == rhs.id
    }
    
    static func loadEmptyArray(storyPageCount: Int) -> [(MiniGamePage, Bool)] {
        var emptyArray: [(MiniGamePage, Bool)] = []
        for i in 0..<storyPageCount {
            emptyArray.append((MiniGamePage(id: nil, order: i, picturePath: "", picture: UIImage()), false))
        }
        return emptyArray
    }
    
    private static func getPage(_ page: PageEntity, order: Int) -> MiniGamePage {
        let picturePath = page.pagePicture.first?.componentContent ?? page.pageVideo.first?.componentContent ?? ""
        return MiniGamePage(id: page.pageId, order: order, picturePath: picturePath, picture: UIImage())
    }
    
    public static func fetchIntroductionPages(story: StoryEntity) -> [MiniGamePage] {
        var draggedPages = [MiniGamePage]()
        for (index, page) in story.pages.enumerated() where page.pageType == "Introduction" {
            draggedPages.append(getPage(page, order: index))
        }
        return draggedPages
    }
    
    public static func fetchDraggedPage(story: StoryEntity) -> [MiniGamePage] {
        var draggedPages = [MiniGamePage]()
        for (index, page) in story.pages.enumerated() where page.pageType == "Instruction" {
            draggedPages.append(getPage(page, order: index))
        }
        return draggedPages
    }
}

