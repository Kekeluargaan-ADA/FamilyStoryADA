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
    var templateCategory: String
    var templateDescription: String
    var templateCoverImagePath: String
    var templateOptionCoverImagePath: [String]
    var tmplatePreviewImagePath: [String]
    
    init(templateId: UUID, templateName: String, templateCategory: String, templateDescription: String, templateCoverImagePath: String, templateOptionCoverImagePath: [String], tmplatePreviewImagePath: [String]) {
        self.templateId = templateId
        self.templateName = templateName
        self.templateCategory = templateCategory
        self.templateDescription = templateDescription
        self.templateCoverImagePath = templateCoverImagePath
        self.templateOptionCoverImagePath = templateOptionCoverImagePath
        self.tmplatePreviewImagePath = tmplatePreviewImagePath
    }
    
    public static func convertToEntity(jsonTemplate: TemplateJSONObject) -> TemplateEntity {
        return TemplateEntity(templateId: jsonTemplate.templateId,
                              templateName: jsonTemplate.templateName,
                              templateCategory: jsonTemplate.templateCategory,
                              templateDescription: jsonTemplate.templateDescription,
                              templateCoverImagePath: jsonTemplate.templateCoverImagePath,
                              templateOptionCoverImagePath: jsonTemplate.templateOptionCoverImagePath,
                              tmplatePreviewImagePath: jsonTemplate.templatePreviewImagePath
        )
    }
}
