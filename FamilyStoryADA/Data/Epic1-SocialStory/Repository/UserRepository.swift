//
//  UserRepository.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 15/10/24.
//

import Foundation
import SwiftData

internal protocol UserRepository {
    func fetchUsers() -> ([UserSwiftData], ErrorHandler?)
    func fetchUserById(userId: UUID) -> (UserSwiftData?, ErrorHandler?)
    func removeUserById(userId: UUID) -> ErrorHandler?
    func addNewUser(user: UserSwiftData) -> (UUID?, ErrorHandler?)
}

internal final class SwiftDataUserRepository: UserRepository {
    private let swiftDataManager = SwiftDataManager.shared
    
    func fetchUsers() -> ([UserSwiftData], ErrorHandler?) {
        do {
            let users = try swiftDataManager.context.fetch(FetchDescriptor<UserSwiftData>())
            return (users, nil)
        } catch {
            print("Error")
            return ([], ErrorHandler.fileNotFound)
        }
    }
    
    func fetchUserById(userId: UUID) -> (UserSwiftData?, ErrorHandler?) {
        let (users, errorHandler) = fetchUsers()
        
        if let error = errorHandler {
            return (nil, error)
        }
        
        let user = users.filter {
            $0.childId == userId
        }.first
        
        guard user != nil else {
            return (nil, ErrorHandler.fileNotFound)
        }
        
        return (user, nil)
    }
    
    func removeUserById(userId: UUID) -> ErrorHandler? {
        let (data, errorHandler) = fetchUserById(userId: userId)
        
        if let error = errorHandler {
            return error
        }
        
        if let deletedData = data {
            swiftDataManager.context.delete(deletedData)
        }
        return nil
    }
    
    func addNewUser(user: UserSwiftData) -> (UUID?, ErrorHandler?) {
        swiftDataManager.context.insert(user)
        
        return (user.childId, nil)
    }
    
    
}
