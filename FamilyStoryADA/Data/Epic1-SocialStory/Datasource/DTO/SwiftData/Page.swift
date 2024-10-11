//
//  Scene.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 09/10/24.
//

import Foundation
import SwiftData

@Model
class Page {
    var pageId: UUID
    var pageText: [TextComponent]
    var pagePicture: [PictureComponent]
    var pageVideo: [VideoComponent]
    var pageSoundPath: String
    
    init (pageId: UUID, pageText: [TextComponent], pagePicture: [PictureComponent], pageVideo: [VideoComponent], pageSoundPath: String) {
        self.pageId = pageId
        self.pageText = pageText
        self.pagePicture = pagePicture
        self.pageVideo = pageVideo
        self.pageSoundPath = pageSoundPath
    }
    
    init (template: PageJSONObject) {
        self.pageId = template.pageId
        
        self.pageText = []
        self.pagePicture = []
        self.pageVideo = []
        self.pageSoundPath = template.pageSoundPath
        
        setupPage(template: template)
    }
    
    fileprivate func setupPage(template: PageJSONObject) {
        for text in template.pageText {
            self.pageText.append(TextComponent(template: text))
        }
        
        for picture in template.pagePicture {
            self.pagePicture.append(PictureComponent(template: picture))
        }
        
        for video in template.pageVideo {
            self.pageVideo.append(VideoComponent(template: video))
        }
    }
}
