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
    var templatePreviewImagePath: [String]
    var templatePagePreview: [PageTemplatePreviewEntity]
    
    init(templateId: UUID, templateName: String, templateCategory: String, templateDescription: String, templateCoverImagePath: String, templateOptionCoverImagePath: [String], templatePreviewImagePath: [String], templatePagePreview: [PageTemplatePreviewEntity]) {
        self.templateId = templateId
        self.templateName = templateName
        self.templateCategory = templateCategory
        self.templateDescription = templateDescription
        self.templateCoverImagePath = templateCoverImagePath
        self.templateOptionCoverImagePath = templateOptionCoverImagePath
        self.templatePreviewImagePath = templatePreviewImagePath
        self.templatePagePreview = templatePagePreview
    }
    
    private static func convertToEntityArray(jsonTemplates: [PageJSONObject]) -> [PageTemplatePreviewEntity] {
        var entities: [PageTemplatePreviewEntity] = []
        for template in jsonTemplates {
            entities.append(PageTemplatePreviewEntity.convertToEntity(jsonTemplate: template))
        }
        return entities
    }
    
    public static func convertToEntity(jsonTemplate: TemplateJSONObject) -> TemplateEntity {
        return TemplateEntity(templateId: jsonTemplate.templateId,
                              templateName: jsonTemplate.templateName,
                              templateCategory: jsonTemplate.templateCategory,
                              templateDescription: jsonTemplate.templateDescription,
                              templateCoverImagePath: jsonTemplate.templateCoverImagePath,
                              templateOptionCoverImagePath: jsonTemplate.templateOptionCoverImagePath,
                              templatePreviewImagePath: jsonTemplate.templatePreviewImagePath,
                              templatePagePreview: convertToEntityArray(jsonTemplates: jsonTemplate.templatePage)
        )
    }
}
