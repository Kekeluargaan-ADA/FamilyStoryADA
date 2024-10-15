//
//  TemplateEntity.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 15/10/24.
//

import Foundation

class TemplateEntity: IEntityAble {
    var templateId: UUID
    var templateName: String
    var templateDescription: String
    var templateCoverImagePath: String
    var tmplatePreviewImagePath: [String]
    
    init(templateId: UUID, templateName: String, templateDescription: String, templateCoverImagePath: String, tmplatePreviewImagePath: [String]) {
        self.templateId = templateId
        self.templateName = templateName
        self.templateDescription = templateDescription
        self.templateCoverImagePath = templateCoverImagePath
        self.tmplatePreviewImagePath = tmplatePreviewImagePath
    }
    
    public static func convertToEntity(jsonTemplate: TemplateJSONObject) -> TemplateEntity {
        return TemplateEntity(templateId: jsonTemplate.templateId,
                              templateName: jsonTemplate.templateName,
                              templateDescription: jsonTemplate.templateDescription,
                              templateCoverImagePath: jsonTemplate.templateCoverImagePath,
                              tmplatePreviewImagePath: jsonTemplate.templatePreviewImagePath
        )
    }
}
