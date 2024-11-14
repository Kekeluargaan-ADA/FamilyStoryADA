//
//  Highlight.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 11/11/24.
//

import Foundation
import SwiftUI


enum PositionStyle {
    case topLeading, topCenter, topTrailing, centerLeading, centerTrailing, bottomLeading, bottomCenter, bottomTrailing
    
    static func calculateXOffset(for position: PositionStyle, highlightRect: CGRect, width: CGFloat) -> CGFloat {
        switch position {
        case .centerLeading:
            return highlightRect.midX - width / 2 - (highlightRect.width / 2 + 150) - 10
        case .centerTrailing:
            return highlightRect.midX - width / 2 + (highlightRect.width / 2 + 150) + 10
        case .topCenter, .bottomCenter:
            return highlightRect.midX - width / 2
        case .topLeading, .bottomLeading:
            return highlightRect.midX - width / 2 - (highlightRect.width / 2 + 150) + highlightRect.width
        case .topTrailing, .bottomTrailing:
            return highlightRect.midX - width / 2 + (highlightRect.width / 2 + 150) - highlightRect.width
        }
    }

    static func calculateYOffset(for position: PositionStyle, highlightRect: CGRect, height: CGFloat) -> CGFloat {
        switch position {
        case .topCenter, .topLeading, .topTrailing:
            return highlightRect.midY - height / 2  - (highlightRect.height / 2 + 80) - 10
        case .bottomCenter, .bottomLeading, .bottomTrailing:
            return highlightRect.midY - height / 2  + (highlightRect.height / 2 + 80) + 10
        case .centerLeading, .centerTrailing:
            return highlightRect.midY - height / 2
//        case .topLeading, .topTrailing:
//            return highlightRect.midY - height / 2  - (highlightRect.height / 2 + 80) + highlightRect.height
//        case .bottomLeading, .bottomTrailing:
//            return highlightRect.midY - height / 2  + (highlightRect.height / 2 + 80) - highlightRect.height
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
