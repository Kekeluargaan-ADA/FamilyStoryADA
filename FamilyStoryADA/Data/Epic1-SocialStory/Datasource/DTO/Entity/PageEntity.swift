//
//  Page.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 14/10/24.
//

import Foundation

public class PageEntity: IEntityAble, Equatable {
    var pageId: UUID
    var pageType: String
    var pageText: [TextComponentEntity]
    var pagePicture: [PictureComponentEntity]
    var pageVideo: [VideoComponentEntity]
    var pageSoundPath: String
    var pageTextClassification: String
    
    var componentTextWordCount: Int {
        var wordCount = 0
        for text in pageText {
            wordCount += text.componentContent.components(separatedBy: " ").count
        }
        return wordCount
    }
    
    init(pageId: UUID, pageType: String, pageText: [TextComponentEntity], pagePicture: [PictureComponentEntity], pageVideo: [VideoComponentEntity], pageSoundPath: String, pageTextClassification: String) {
        self.pageId = pageId
        self.pageType = pageType
        self.pageText = pageText
        self.pagePicture = pagePicture
        self.pageVideo = pageVideo
        self.pageSoundPath = pageSoundPath
        self.pageTextClassification = pageTextClassification
    }
    
    public static func == (lhs: PageEntity, rhs: PageEntity) -> Bool {
            return lhs.pageId == rhs.pageId
        }
}
