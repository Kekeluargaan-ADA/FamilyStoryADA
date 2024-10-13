//
//  TemplateUsecase.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 13/10/24.
//

import Foundation

protocol TemplateUsecase {
    func fetchTemplates() -> [TemplateJSONObject]
    func fetchTemplateById(templateId: UUID) -> TemplateJSONObject?
}

class JSONTemplateUsecase: TemplateUsecase {
    
    private let templateRepository = JSONTemplateRepository()
    
    func fetchTemplates() -> [TemplateJSONObject] {
        let (templates, error) = templateRepository.fetchTemplates()
        
        guard error == nil else {
            return []
        }
        return templates
    }
    
    func fetchTemplateById(templateId: UUID) -> TemplateJSONObject? {
        let (template, error) = templateRepository.fetchTemplatesById(templateId: templateId)
        
        guard error == nil else {
            return nil
        }
        return template
    }
    
    
}
