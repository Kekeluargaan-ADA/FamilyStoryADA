//
//  PageUsecase.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import Foundation

internal protocol PageUsecase {
    func fetchPagesByStoryId(storyId: UUID) -> [PageEntity]
    func fetchPageById(pageId: UUID) -> PageEntity?
    func addPage(page: PageEntity) -> UUID?
    func removePage(pageId: UUID) -> Bool
    func editPage(page: PageEntity) -> Bool
}

public class ImplementedPageUsecase: PageUsecase {
    private let storyUsecase: StoryUsecase
    private let pageRepository: PageRepository
    
    public static let shared = ImplementedPageUsecase()
    
    private init() {
        storyUsecase = ImplementedStoryUsecase.shared
        pageRepository = SwiftDataPageRepository.shared
    }
    
    func fetchPagesByStoryId(storyId: UUID) -> [PageEntity] {
        if let story = storyUsecase.fetchStoryById(storyId: storyId) {
            return story.pages
        }
        return []
    }
    
    func fetchPageById(pageId: UUID) -> PageEntity? {
        let (page, error) = pageRepository.fetchPageById(pageId: pageId)
        guard error == nil else { return nil }
        return page?.convertToEntity()
    }
    
    func addPage(page: PageEntity) -> UUID? {
        let pageSwiftData = PageSwiftData.convertToSwiftData(entity: page)
        let (pageId, error) = pageRepository.addNewPage(page: pageSwiftData)
        guard error == nil else { return nil }
        return pageId
    }
    
    func removePage(pageId: UUID) -> Bool {
        let error = pageRepository.removePageById(pageId: pageId)
        guard error == nil else { return false }
        return true
    }
    
    func editPage(page: PageEntity) -> Bool {
        //TODO: get index in story -> biar ordernya sama
        let (swiftDataPage, error) = pageRepository.fetchPageById(pageId: page.pageId)
        
        guard error == nil else {
            return false
        }
        
        if let data = swiftDataPage {
            guard pageRepository.removePageById(pageId: data.pageId) == nil else {
                return false
            }
            
            let (pageId, error) = pageRepository.addNewPage(page: PageSwiftData.convertToSwiftData(entity: page))
            
            guard pageId == page.pageId && error == nil else {
                return false
            }
            return true
        }
        return false
    }
    
    
}
