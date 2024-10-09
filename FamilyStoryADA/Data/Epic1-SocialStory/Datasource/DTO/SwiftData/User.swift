//
//  User.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 09/10/24.
//

import Foundation
import SwiftData

@Model
class User {
    var childId: UUID
    var childName: String
    var childPicturePath: String
    
    init(childId: UUID, childName: String, childPicturePath: String) {
        self.childId = childId
        self.childName = childName
        self.childPicturePath = childPicturePath
    }
}
