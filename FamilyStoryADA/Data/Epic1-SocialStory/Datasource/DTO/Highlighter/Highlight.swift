//
//  Highlight.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 11/11/24.
//

import Foundation
import SwiftUI


enum PositionStyle {
    case top, left, right, bottom
    
    static func calculateXOffset(for position: PositionStyle, highlightRect: CGRect) -> CGFloat {
        switch position {
        case .left:
            return highlightRect.minX - 10
        case .right:
            return highlightRect.maxX + 10
        case .top, .bottom:
            return highlightRect.midX
        }
    }

    static func calculateYOffset(for position: PositionStyle, highlightRect: CGRect) -> CGFloat {
        switch position {
        case .top:
            return highlightRect.minY - 10
        case .bottom:
            return highlightRect.maxY + 10
        case .left, .right:
            return highlightRect.midY
        }
    }
}

struct Highlight: Identifiable, Equatable {
    var id: UUID = .init()
    var anchor: Anchor<CGRect>
    var title: String
    var description: String
    var cornerRadius: CGFloat
    var style: RoundedCornerStyle = .continuous
    var scale: CGFloat = 1
    var position: PositionStyle
}
