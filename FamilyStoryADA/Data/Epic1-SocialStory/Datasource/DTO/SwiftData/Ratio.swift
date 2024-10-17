//
//  Ratio.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 09/10/24.
//

import Foundation
import SwiftData

@Model
class RatioSwiftData: Identifiable, ISwiftDataAble {
    var ratioId: UUID
    var xRatio: Double  // horizontal position, 0.0 - 1.0 based on device screen
    var yRatio: Double  // vertical position, 0.0 - 1.0 based on device screen
    var zRatio: Int     // 0 = background, 1 = foreground
    
    init(ratioId: UUID, xRatio: Double, yRatio: Double, zRatio: Int) {
        self.ratioId = ratioId
        self.xRatio = xRatio
        self.yRatio = yRatio
        self.zRatio = zRatio
    }
    
//    init(template: RatioJSONObject) {
//        self.ratioId = UUID()
//        self.xRatio = template.xRatio
//        self.yRatio = template.yRatio
//        self.zRatio = template.zRatio
//    }
    
    static func convertToSwiftData(jsonTemplate: RatioJSONObject) -> RatioSwiftData {
        return RatioSwiftData(ratioId: UUID(),
                              xRatio: jsonTemplate.xRatio,
                              yRatio: jsonTemplate.yRatio,
                              zRatio: jsonTemplate.zRatio
        )
    }
    
    static func convertToSwiftData(entity: RatioEntity) -> RatioSwiftData {
        return RatioSwiftData(ratioId: entity.ratioId,
                              xRatio: entity.xRatio,
                              yRatio: entity.yRatio,
                              zRatio: entity.zRatio
        )
    }
    
    func convertToEntity() -> RatioEntity {
        return RatioEntity(ratioId: self.ratioId,
                           xRatio: self.xRatio,
                           yRatio: self.yRatio,
                           zRatio: self.zRatio
        )
    }
}
