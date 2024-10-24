//
//  TemplateViewModel.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 15/10/24.
//

import SwiftUI

// TODO: PINDAHIN KE MANAGER KALO LOGIC BUSINESS

class TemplateViewModel: ObservableObject {
    @Published var templates: [TemplateEntity] = []
    @Published var filteredTemplates: [TemplateEntity] = []
    
    @Published var isPagePreviewModalPresented = false
    @Published var isImageInputModalPresented = false
    @Published var selectedTemplate: TemplateEntity?
    @Published var createdStory: StoryEntity?
    @Published var isEditingTextField: Bool = false
    @Published var childName: String = ""
    
    private let templateUsecase: TemplateUsecase
    private let storyUsecase: StoryUsecase
    private let pageUsecase: PageUsecase
    private let componentUsecase: ComponentUsecase
    
    init() {
        self.templateUsecase = JSONTemplateUsecase()
        self.storyUsecase = ImplementedStoryUsecase()
        self.pageUsecase = ImplementedPageUsecase()
        self.componentUsecase = ImplementedComponentUsecase()
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
    
    func addNewStory(templateId: UUID) -> UUID? {
        let storyId = storyUsecase.addNewStory(templateId: templateId)
        return storyId
    }
    
    func fetchStoryById(storyId: UUID) -> StoryEntity? {
        return storyUsecase.fetchStoryById(storyId: storyId)
    }
    
    func editNewStory(imageName: String?) {
        if let template = selectedTemplate {
            if let storyId = addNewStory(templateId: template.templateId) {
                self.createdStory = fetchStoryById(storyId: storyId)
            }
            if let editedStory = self.createdStory {
                let imageFileName = imageName
                let childName = self.childName
                
                for page in editedStory.pages {
                    if page.pageType == "Opening" || page.pageType == "Closing" {
                        if let fileName = imageFileName {
                            page.pagePicture.append(PictureComponentEntity(componentId: UUID(),
                                                                                                  componentContent: fileName,
                                                                                                  componentCategory: "AppStoragePicture"))
                        }
                        if !page.pageText.isEmpty {
                            page.pageText[0].componentContent = page.pageText[0].componentContent.replacingOccurrences(of: "<CHILD_NAME>", with: childName)
                        }
                        updatePage(page: page)
                    }
                }
            }
        }
    }
    
    public func updatePage(page: PageEntity) {
        updateTextComponent(page: page)
        updateMedia(page: page)
    }
    
    private func updateTextComponent(page: PageEntity) {
        if let text = page.pageText.first {
            if componentUsecase.updateComponent(component: text), let changedPage = createdStory?.pages.first(where: {$0.pageId == page.pageId}) {
                changedPage.pageText = []
                changedPage.pageText.append(text)
            } else {
                if componentUsecase.addNewComponent(component: text) != nil {
                    page.pageText = []
                    page.pageText.append(text)
                    
                    _ = pageUsecase.editPage(page: page)
                }
            }
        }
    }
    
    private func updateMedia(page: PageEntity) {
        // If there is picture input
        if let picture = page.pagePicture.first {
            if componentUsecase.updateComponent(component: picture) {
                page.pagePicture = []
                page.pagePicture.append(picture)
            } else {
                if componentUsecase.addNewComponent(component: picture) != nil {
                    page.pagePicture = []
                    page.pagePicture.append(picture)
                    _ = pageUsecase.editPage(page: page)
                }
            }
        }
    }
}
