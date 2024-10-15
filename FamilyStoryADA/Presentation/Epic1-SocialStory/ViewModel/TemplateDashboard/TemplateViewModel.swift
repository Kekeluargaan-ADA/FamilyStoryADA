//
//  TemplateViewModel.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 15/10/24.
//

import SwiftUI

class TemplateViewModel: ObservableObject {
    @Published var templates: [TemplateEntity] = []
    
    private let templateUsecase: TemplateUsecase
    
    init(templateUsecase: TemplateUsecase) {
        self.templateUsecase = templateUsecase
        fetchTemplates()
    }
    
    func fetchTemplates() {
        templates = templateUsecase.fetchTemplates()
    }
}
