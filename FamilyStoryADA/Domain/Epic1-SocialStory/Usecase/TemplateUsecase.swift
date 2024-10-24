//
//  TemplateUsecase.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import Foundation

protocol TemplateUsecase {
    func fetchTemplates() -> [TemplateEntity]
    func fetchTemplateById(templateId: UUID) -> TemplateEntity?
}

public final class JSONTemplateUsecase: TemplateUsecase {
    
    private let templateRepository = JSONTemplateRepository.shared
    public static let shared = JSONTemplateUsecase()
    private init() {
        
    }
    
    func fetchTemplates() -> [TemplateEntity] {
        let (templates, error) = templateRepository.fetchTemplates()
        guard error == nil else {
            return []
        }
        
        var templateEntities: [TemplateEntity] = []
        
        for template in templates {
            let entity = TemplateEntity.convertToEntity(jsonTemplate: template)
            templateEntities.append(entity)
        }
        return templateEntities
    }
    
    func fetchTemplateById(templateId: UUID) -> TemplateEntity? {
        let (template, error) = templateRepository.fetchTemplatesById(templateId: templateId)
        
        guard error == nil else {
            return nil
        }
        
        if let jsonTemplate = template {
            return TemplateEntity.convertToEntity(jsonTemplate: jsonTemplate)
        }
        return nil
    }
    
    
}
