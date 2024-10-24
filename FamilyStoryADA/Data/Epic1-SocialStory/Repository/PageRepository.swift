//
//  PageRepository.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 14/10/24.
//

import Foundation
import SwiftData

internal protocol PageRepository {
    func fetchAllPages() -> ([PageSwiftData], ErrorHandler?)
    func fetchPageById(pageId: UUID) -> (PageSwiftData?, ErrorHandler?)
    func removePageById(pageId: UUID) -> ErrorHandler?
    func addNewPage(page: PageSwiftData) -> (UUID?, ErrorHandler?)
    func savePage() -> ErrorHandler?
}

internal final class SwiftDataPageRepository: PageRepository {
    
    private let swiftDataManager = SwiftDataManager.shared
    public static let shared = SwiftDataPageRepository()
    private init() {
        
    }
    
    func fetchAllPages() -> ([PageSwiftData], ErrorHandler?) {
        do {
            let pages = try swiftDataManager.context.fetch(FetchDescriptor<PageSwiftData>())
            return (pages, nil)
        } catch {
            return ([], ErrorHandler.fileNotFound)
        }
    }
    
    func fetchPageById(pageId: UUID) -> (PageSwiftData?, ErrorHandler?) {
        let (pages, errorHandler) = fetchAllPages()
        
        if let error = errorHandler {
            return (nil, error)
        }
        
        let page = pages.filter {
            $0.pageId == pageId
        }.first
        
        guard page != nil else {
            return (nil, ErrorHandler.fileNotFound)
        }
        
        return (page, nil)
    }
    
    func removePageById(pageId: UUID) -> ErrorHandler? {
        let (data, errorHandler) = fetchPageById(pageId: pageId)
        
        if let error = errorHandler {
            return error
        }
        
        if let deletedData = data {
            swiftDataManager.context.delete(deletedData)
        }
        return nil
    }
    
    func addNewPage(page: PageSwiftData) -> (UUID?, ErrorHandler?) {
        swiftDataManager.context.insert(page)
        
        return (page.pageId, nil)
    }
    
    func savePage() -> ErrorHandler? {
        do {
            try swiftDataManager.context.save()
        } catch {
            return ErrorHandler.dataCorrupted
        }
        
        return nil
    }
}
