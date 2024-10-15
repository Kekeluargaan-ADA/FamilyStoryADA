//
//  User.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 14/10/24.
//

import Foundation


public class UserEntity: IEntityAble {
    var childId: UUID
    var childName: String
    var childPicturePath: String
    
    init(childId: UUID, childName: String, childPicturePath: String) {
        self.childId = childId
        self.childName = childName
        self.childPicturePath = childPicturePath
    }
}
