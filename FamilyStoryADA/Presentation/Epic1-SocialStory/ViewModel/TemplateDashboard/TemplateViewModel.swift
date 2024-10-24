//
//  TemplateViewModel.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 15/10/24.
//

import SwiftUI

class TemplateViewModel: ObservableObject {
    @Published var templates: [TemplateEntity] = []
    @Published var filteredTemplates: [TemplateEntity] = []
    
    @Published private var isModalPresented = false
    @Published private var selectedTemplate: TemplateEntity?
    
    private let templateUsecase: TemplateUsecase
    
    init() {
        self.templateUsecase = JSONTemplateUsecase()
        fetchTemplates()
    }
    
    func fetchTemplates() {
        templates = templateUsecase.fetchTemplates()
    }
    
    func filterTemplates(by category: String?) {
        if let category = category {
            filteredTemplates = templates.filter { $0.templateCategory == category }
        } else {
            filteredTemplates = templates
        }
    }
}
