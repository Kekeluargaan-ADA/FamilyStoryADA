//
//  Page.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 14/10/24.
//

import Foundation

public class PageEntity: IEntityAble {
    var pageId: UUID
    var pageText: [TextComponentEntity]
    var pagePicture: [PictureComponentEntity]
    var pageVideo: [VideoComponentEntity]
    var pageSoundPath: String
    
    init(pageId: UUID, pageText: [TextComponentEntity], pagePicture: [PictureComponentEntity], pageVideo: [VideoComponentEntity], pageSoundPath: String) {
        self.pageId = pageId
        self.pageText = pageText
        self.pagePicture = pagePicture
        self.pageVideo = pageVideo
        self.pageSoundPath = pageSoundPath
    }
}
