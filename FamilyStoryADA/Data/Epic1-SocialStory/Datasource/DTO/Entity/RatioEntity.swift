//
//  Ratio.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 14/10/24.
//

import Foundation

public class RatioEntity: IEntityAble {
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
    
    init(data: RatioSwiftData) {
        self.ratioId = data.ratioId
        self.xRatio = data.xRatio
        self.yRatio = data.yRatio
        self.zRatio = data.zRatio
    }
}
