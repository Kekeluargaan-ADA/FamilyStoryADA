//
//  TemplateRepository.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 09/10/24.
//

import Foundation

internal protocol TemplateRepository {
    func fetchTemplates() -> ([TemplateJSONObject], ErrorHandler?)
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
    
    
}
