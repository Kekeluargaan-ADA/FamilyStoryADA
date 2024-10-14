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
    
//    func convertToSwiftData(jsonTemplate: any IJSONAble) -> any ISwiftDataAble {
//        <#code#>
//    }
//    
//    func convertToSwiftData(entity: any IEntityAble) -> any ISwiftDataAble {
//        <#code#>
//    }
//    
//    func convertToEntity() -> any IEntityAble {
//        <#code#>
//    }
}
