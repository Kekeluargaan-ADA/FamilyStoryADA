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
    @Published private(set) var currentPageIndex: Int = 0 // Accessible externally but modifiable only internally

    private let templateRepository: TemplateRepository
    public var templatePages: [PageJSONObject] = [] // Keep this private
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
        
        // Assign all pages to templatePages
        templatePages = template.templatePage
        
        // Find the index of the page matching pageId
        if let index = templatePages.firstIndex(where: { $0.pageId == pageId }) {
            currentPageIndex = index
            updatePageContent()
        }
    }
    
    func goToNextPage() {
        guard currentPageIndex < templatePages.count - 1 else { return }
        currentPageIndex += 1
        updatePageContent()
    }
    
    func goToPreviousPage() {
        guard currentPageIndex > 0 else { return }
        currentPageIndex -= 1
        updatePageContent()
    }
    
    private func updatePageContent() {
        let currentPage = templatePages[currentPageIndex]
        if let textComponent = currentPage.pageText.first {
            pageText = textComponent.componentContent
        } else {
            pageText = ""
        }
    }
    
    // Computed properties for accessing page navigation information
    var canGoToNextPage: Bool {
        currentPageIndex < templatePages.count - 1
    }
    
    var canGoToPreviousPage: Bool {
        currentPageIndex > 0
    }
}
