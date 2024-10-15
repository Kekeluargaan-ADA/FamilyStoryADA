//
//  User.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 09/10/24.
//

import Foundation
import SwiftData

@Model
class UserSwiftData: Identifiable, ISwiftDataAble {
    var childId: UUID
    var childName: String
    var childPicturePath: String
    
    init(childId: UUID, childName: String, childPicturePath: String) {
        self.childId = childId
        self.childName = childName
        self.childPicturePath = childPicturePath
    }
    
    static func convertToSwiftData(entity: UserEntity) -> UserSwiftData {
        return UserSwiftData(childId: entity.childId,
                             childName: entity.childName,
                             childPicturePath: entity.childPicturePath
        )
    }
    
    func convertToEntity() -> UserEntity {
        return UserEntity(childId: self.childId,
                          childName: self.childName,
                          childPicturePath: self.childPicturePath
        )
    }
}
