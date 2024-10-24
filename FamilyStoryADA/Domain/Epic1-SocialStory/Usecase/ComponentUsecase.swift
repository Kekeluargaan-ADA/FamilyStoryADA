//
//  ComponentUsecase.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 18/10/24.
//

import Foundation

protocol ComponentUsecase {
    func fetchComponentById(componentId: UUID, type: StoryComponentType) -> StoryComponentEntity?
    func addNewComponent(component: StoryComponentEntity) -> UUID?
    func removeComponent(componentId: UUID) -> Bool
    func updateComponent(component: StoryComponentEntity) -> Bool
}

public class ImplementedComponentUsecase: ComponentUsecase {
    
    private var repository: ComponentRepository
    public static let shared = ImplementedComponentUsecase()
    
    private init() {
        repository = SwiftDataComponentRepository.shared
    }
    
    func fetchComponentById(componentId: UUID, type: StoryComponentType) -> StoryComponentEntity? {
        let (component, error) = repository.fetchComponentById(componentId: componentId)
        
        guard error == nil else {
            return nil
        }
        
        return component?.convertToEntity(type: type)
    }
    
    func addNewComponent(component: StoryComponentEntity) -> UUID? {
        let (componentId, error) = repository.addNewComponent(component: StoryComponentSwiftData.convertToSwiftData(entity: component))
        
        guard error == nil else {
            return nil
        }
        
        return componentId
    }
    
    func removeComponent(componentId: UUID) -> Bool {
        let error = repository.removeComponentById(componentId: componentId)
        
        guard error == nil else {
            return false
        }
        
        return true
    }
    
    func updateComponent(component: StoryComponentEntity) -> Bool {
        let (componentSwiftData, error) = repository.fetchComponentById(componentId: component.componentId)
        
        guard error == nil else {
            return false
        }
        
        if let data = componentSwiftData {
            guard repository.removeComponentById(componentId: component.componentId) == nil else {
                return false
            }
            
            let (componentId, error) = repository.addNewComponent(component: StoryComponentSwiftData.convertToSwiftData(entity: component))
            
            guard componentId == component.componentId && error == nil else {
                return false
            }
            return true
        }
        return false
    }
    
    
}
