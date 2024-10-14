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
    @MainActor @Test
    func testCreatingRatio() {
        let repo = SwiftDataRatioRepository()
        
        let ratio = RatioSwiftData(ratioId: UUID(), xRatio: 4.0, yRatio: 0.0, zRatio: 1)
        _ = repo.addNewRatio(ratio: ratio)
        
        let (ratios, error) = repo.fetchAllRatio()
//        #expect(ratios.count != 0, "Ratio is nil")
        
        #expect(ratios.last?.xRatio == 4.0, "not correct value")
    }
    
}
