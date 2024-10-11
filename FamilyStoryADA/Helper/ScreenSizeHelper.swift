//
//  ScreenSizeHelper.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 11/10/24.
//

import SwiftUI

struct ScreenSizeHelper {
    static func calculateRatios(geometry: GeometryProxy) -> (heightRatio: CGFloat, widthRatio: CGFloat) {
        let screenHeight = geometry.size.height
        let screenWidth = geometry.size.width
        let heightRatio = screenHeight / SizeConstants.baseHeight
        let widthRatio = screenWidth / SizeConstants.baseWidth
        return (heightRatio, widthRatio)
    }
}
