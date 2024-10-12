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
    
    //TODO: Fix tests
//    @MainActor @Test
//    func testCreatingStory() {
//        let storyRepository = SwiftDataStoryRepository.shared
//        let templateId = UUID(uuidString: "819f2cc6-345d-4bfa-b081-2b0d4afc53ab")
//        
//        if let templateUUID = templateId{
//            let (uuid, response) = storyRepository.addNewStory(templateId: templateUUID)
//            
//            print(uuid)
//            #expect(response == nil, "Error creating model")
//        }
//    }
    
}
