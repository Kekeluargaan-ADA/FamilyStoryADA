//
//  PageTemplatePreviewEntity.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 29/10/24.
//

import Foundation

class PageTemplatePreviewEntity: IEntityAble {
    var templateText: String?
    var templateImage: String?
    var templatePageCategory: String
    
    var componentTextWordCount: Int {
        return (templateText?.count(where: { $0 == " "}) ?? 0) + 1
    }
    
    init(templateText: String?, templateImage: String?, templatePageCategory: String) {
        self.templateText = templateText
        self.templateImage = templateImage
        self.templatePageCategory = templatePageCategory
    }
    
    public static func convertToEntity(jsonTemplate: PageJSONObject) -> PageTemplatePreviewEntity {
        return PageTemplatePreviewEntity(templateText: jsonTemplate.pageText.first?.componentContent,
                                         templateImage: jsonTemplate.pageVideo.first?.componentContent == nil ? jsonTemplate.pagePicture.first?.componentContent : jsonTemplate.pageVideo.first?.componentContent,
                                         templatePageCategory: jsonTemplate.pageType
                                         )
    }
}
