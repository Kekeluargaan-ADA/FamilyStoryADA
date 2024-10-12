//
//  Ratio.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 09/10/24.
//

import Foundation
import SwiftData

@Model
class Ratio {
    var xRatio: Double  // horizontal position, 0.0 - 1.0 based on device screen
    var yRatio: Double  // vertical position, 0.0 - 1.0 based on device screen
    var zRatio: Int     // 0 = background, 1 = foreground
    
    init(xRatio: Double, yRatio: Double, zRatio: Int) {
        self.xRatio = xRatio
        self.yRatio = yRatio
        self.zRatio = zRatio
    }
    
    init(template: RatioJSONObject) {
        self.xRatio = template.xRatio
        self.yRatio = template.yRatio
        self.zRatio = template.zRatio
    }
}
