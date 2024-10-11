//
//  PlayStoryViewModel.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 11/10/24.
//

import SwiftUI
import Combine

final class PlayStoryViewModel: ObservableObject {
    @Published var templateName: String = ""
    @Published var pageText: String = ""
    
    private let templateRepository: TemplateRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(templateRepository: TemplateRepository, templateId: UUID, pageId: UUID) {
        self.templateRepository = templateRepository
        fetchTemplateData(templateId: templateId, pageId: pageId)
    }
    
    private func fetchTemplateData(templateId: UUID, pageId: UUID) {
        let (template, error) = templateRepository.fetchTemplatesById(templateId: templateId)
        
        guard let template = template, error == nil else {
            // Handle error (e.g., set default values or show an error message)
            return
        }
        
        // Update the template name
        templateName = template.templateName
        
        // Find the page text content based on pageId
        if let page = template.templatePage.first(where: { $0.pageId == pageId }),
           let textComponent = page.pageText.first {
            pageText = textComponent.componentContent
        }
    }
}
