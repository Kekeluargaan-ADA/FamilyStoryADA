//
//  UserUsecase.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 15/10/24.
//

import Foundation

internal protocol UserUsecase {
    func fetchUsers() -> [UserEntity]
    func fetchUserById(userId: UUID) -> UserEntity?
}

public final class ImplementedUserUsecase: UserUsecase {
    private let repository: UserRepository
    
    init() {
        self.repository = SwiftDataUserRepository()
    }
    
    func fetchUsers() -> [UserEntity] {
        let (users, error) = repository.fetchUsers()
        
        guard error == nil else {
            return []
        }
        
        var userEntities: [UserEntity] = []
        for user in users {
            let userEntity = user.convertToEntity()
            userEntities.append(userEntity)
        }
        
        return userEntities
    }
    
    func fetchUserById(userId: UUID) -> UserEntity? {
        let (user, error) = repository.fetchUserById(userId: userId)
        
        guard error == nil else {
            return nil
        }
        return user?.convertToEntity()
    }
    
    
}
