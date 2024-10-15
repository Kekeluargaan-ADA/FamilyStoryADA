//
//  FamilyStoryADATests.swift
//  FamilyStoryADATests
//
//  Created by Nathanael Juan Gauthama on 23/09/24.
//

import Testing
@testable import FamilyStoryADA
import Foundation
import SwiftData

struct FamilyStoryADATests {
    
    @Test
    func testFetchTemplates() {
        let templateRepository = JSONTemplateRepository()
        let fileManager = FileManager.default
        if let filePath = Bundle.main.path(forResource: "Template", ofType: "json") {
            #expect(fileManager.fileExists(atPath: filePath), "Template.json does not exist")
        } else {
            #expect((Bundle.main.path(forResource: "Template", ofType: "json") != nil), "Template.json does not exist")
            return
        }
        
        let listTemplate = templateRepository.fetchTemplates()
        
        #expect(!listTemplate.0.isEmpty, "list template is null")
    }
    
    @Test
    func testCreatingRatio() {
        let repo = SwiftDataRatioRepository()
        
        let ratio = RatioSwiftData(ratioId: UUID(), xRatio: 4.0, yRatio: 0.0, zRatio: 1)
        _ = repo.addNewRatio(ratio: ratio)
        
        let (ratios, _) = repo.fetchAllRatio()
        #expect(ratios.count != 0, "Ratio is nil")
        
        #expect(ratios.contains(where: {$0.xRatio == 4.0} ), "not correct value")
    }
    
    @Test
    func testCreatingComponent() {
        let repo = SwiftDataComponentRepository()
        
        let ratio = RatioSwiftData(ratioId: UUID(), xRatio: 4.0, yRatio: 0.0, zRatio: 1)
        let component = StoryComponentSwiftData(componentId: UUID(), componentContent: "DummyContent", componentRatioId: ratio.ratioId, componentScale: nil, componentRotation: 0.0)
        _ = repo.addNewComponent(component: component)
        
        let (components, _) = repo.fetchAllComponents()
        print(components)
        #expect(components.count != 0, "components is nil")
        
        #expect(components.contains(where: {ratio.ratioId == $0.componentRatioId} ), "Ratio not in")
        #expect(components.contains(where: {$0.componentContent == "DummyContent"}), "not correct value")
    }
    
    @Test
    func testCreatingPage() {
        let repo = SwiftDataPageRepository()
        
        let ratio = RatioSwiftData(ratioId: UUID(), xRatio: 4.0, yRatio: 0.0, zRatio: 1)
        let imageComponent = StoryComponentSwiftData(componentId: UUID(), componentContent: "DummyImage", componentRatioId: ratio.ratioId, componentScale: nil, componentRotation: 0.0)
        let textComponent = StoryComponentSwiftData(componentId: UUID(), componentContent: "DummyText1", componentRatioId: ratio.ratioId, componentScale: nil, componentRotation: 0.0)
        let textComponent2 = StoryComponentSwiftData(componentId: UUID(), componentContent: "DummyText2", componentRatioId: ratio.ratioId, componentScale: nil, componentRotation: 0.0)
        let page = PageSwiftData(pageId: UUID(),
                                 pageText: [
                                    textComponent.componentId,
                                    textComponent2.componentId
                                 ],
                                 pagePicture: [
                                    imageComponent.componentId
                                 ],
                                 pageVideo: [
                                    
                                 ],
                                 pageSoundPath: "DummySound.mp4"
        )
        _ = repo.addNewPage(page: page)
        
        let (pages, error) = repo.fetchAllPages()
        
        #expect(error == nil, "Error fetching")
        #expect(pages.count != 0, "components is nil")
        
        #expect(pages.contains(where: { $0.pagePicture.contains(where: {$0 == imageComponent.componentId}) } ), "Page picture not in")
        #expect(pages.first?.pageSoundPath == "DummySound.mp4", "not correct value")
    }
    
    @Test
    func testFetchStoryEntity() {
        let storyUsecase = ImplementedStoryUsecase()
        
        if let templateUUID = UUID(uuidString: "819f2cc6-345d-4bfa-b081-2b0d4afc53ab") {
            let storyId = storyUsecase.addNewStory(templateId: templateUUID)
            
            #expect(storyId != nil, "story has not been created")
            
            if let fixedStoryId = storyId {
                let storyEntity = storyUsecase.fetchStoryById(storyId: fixedStoryId)
                
                #expect(storyEntity != nil, "story entity has not been created")
                
                #expect(!(storyEntity?.pages.isEmpty ?? true), "have no page")
            }
        }
    }
    
}
