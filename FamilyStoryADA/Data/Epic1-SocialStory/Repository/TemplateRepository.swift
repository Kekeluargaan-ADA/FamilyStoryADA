//
//  TemplateRepository.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 09/10/24.
//

import Foundation

internal protocol TemplateRepository {
    func fetchTemplates() -> ([TemplateJSONObject], ErrorHandler?)
    func fetchTemplatesById(templateId: UUID) -> (TemplateJSONObject?, ErrorHandler?)
}

internal final class JSONTemplateRepository: TemplateRepository {
    
    private let jsonManager = JsonManager.shared
    
    func fetchTemplates() -> ([TemplateJSONObject], ErrorHandler?) {
        let result = jsonManager.loadJSONData(from: "Template", as: [TemplateJSONObject].self)
        
        switch result {
        case .success(let templates):
            return (templates, nil)
        case .failure(let error):
            return ([], error)
        }
    }
    
    func fetchTemplatesById(templateId: UUID) -> (TemplateJSONObject?, ErrorHandler?) {
        let (templates, errorResult) = fetchTemplates()
        
        if let error = errorResult {
            return (nil, error)
        }
        
        let result = templates.filter {
            $0.templateId == templateId
        }.first
        
        guard result != nil else {
            return (nil, ErrorHandler.fileNotFound)
        }
        
        return (result, nil)
    }
}
