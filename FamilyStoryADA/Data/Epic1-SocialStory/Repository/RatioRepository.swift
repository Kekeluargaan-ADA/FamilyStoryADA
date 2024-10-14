//
//  RatioRepository.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 14/10/24.
//

import Foundation
import SwiftData

internal protocol RatioRepository {
    func fetchAllRatio() -> ([RatioSwiftData], ErrorHandler?)
    func fetchRatioById(ratioId: UUID) -> (RatioSwiftData?, ErrorHandler?)
    func removeRatioById(ratioId: UUID) -> ErrorHandler?
    func addNewRatio(ratio: RatioSwiftData) -> (UUID?, ErrorHandler?)
}

internal final class SwiftDataRatioRepository: RatioRepository {
    
    private let swiftDataManager = SwiftDataManager.shared
    
    func fetchAllRatio() -> ([RatioSwiftData], ErrorHandler?) {
        do {
            let ratios = try swiftDataManager.context.fetch(FetchDescriptor<RatioSwiftData>())
            print("ratio: \(ratios.first?.xRatio)")
            print("Count: \(ratios.count)")
            return (ratios, nil)
        } catch {
            print("Error")
            return ([], ErrorHandler.fileNotFound)
        }
    }
    
    func fetchRatioById(ratioId: UUID) -> (RatioSwiftData?, ErrorHandler?) {
        let (ratios, errorHandler) = fetchAllRatio()
        
        if let error = errorHandler {
            return (nil, error)
        }
        
        let ratio = ratios.filter {
            $0.ratioId == ratioId
        }.first
        
        guard ratio != nil else {
            return (nil, ErrorHandler.fileNotFound)
        }
        
        return (ratio, nil)
    }
    
    func removeRatioById(ratioId: UUID) -> ErrorHandler? {
        let (data, errorHandler) = fetchRatioById(ratioId: ratioId)
        
        if let error = errorHandler {
            return error
        }
        
        if let deletedData = data {
            swiftDataManager.context.delete(deletedData)
        }
        return nil
    }
    
    func addNewRatio(ratio: RatioSwiftData) -> (UUID?, ErrorHandler?) {
        swiftDataManager.context.insert(ratio)
        
        return (ratio.ratioId, nil)
    }
    
    
}
