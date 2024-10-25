//
//  ComponentRepository.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 14/10/24.
//

import Foundation
import SwiftData

internal protocol ComponentRepository {
    func fetchAllComponents() -> ([StoryComponentSwiftData], ErrorHandler?)
    func fetchComponentById(componentId: UUID) -> (StoryComponentSwiftData?, ErrorHandler?)
    func removeComponentById(componentId: UUID) -> ErrorHandler?
    func addNewComponent(component: StoryComponentSwiftData) -> (UUID?, ErrorHandler?)
    func saveComponent() -> ErrorHandler?
}

internal final class SwiftDataComponentRepository: ComponentRepository {
    private let swiftDataManager = SwiftDataManager.shared
    
    public static let shared = SwiftDataComponentRepository()
    private init() {
        
    }
    
    func fetchAllComponents() -> ([StoryComponentSwiftData], ErrorHandler?) {
        do {
            let components = try swiftDataManager.context.fetch(FetchDescriptor<StoryComponentSwiftData>())
            return (components, nil)
        } catch {
            return ([], ErrorHandler.fileNotFound)
        }
    }
    
    func fetchComponentById(componentId: UUID) -> (StoryComponentSwiftData?, ErrorHandler?) {
        let (components, errorHandler) = fetchAllComponents()
        
        if let error = errorHandler {
            return (nil, error)
        }
        
        let component = components.filter {
            $0.componentId == componentId
        }.first
        
        guard component != nil else {
            return (nil, ErrorHandler.fileNotFound)
        }
        
        return (component, nil)
    }
    
    func removeComponentById(componentId: UUID) -> ErrorHandler? {
        let (data, errorHandler) = fetchComponentById(componentId: componentId)
        
        if let error = errorHandler {
            return error
        }
        
        if let deletedData = data {
            swiftDataManager.context.delete(deletedData)
        }
        return nil
    }
    
    func addNewComponent(component: StoryComponentSwiftData) -> (UUID?, ErrorHandler?) {
        swiftDataManager.context.insert(component)
        
        return (component.componentId, nil)
    }
    
    func saveComponent() -> ErrorHandler? {
        do {
            try swiftDataManager.context.save()
        } catch {
            return ErrorHandler.dataCorrupted
        }
        
        return nil
    }
}
