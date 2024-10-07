//
//  ImageCropPath.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 04/10/24.
//

import Foundation
import SwiftUICore

struct ImageCropPath: Shape {
    func path(in rect: CGRect) -> Path {
            var path = Path()
            let width = rect.size.width
            let height = rect.size.height
            path.move(to: CGPoint(x: 0.99634*width, y: 0.5*height))
            path.addCurve(to: CGPoint(x: 0.5*width, y: 0.99708*height), control1: CGPoint(x: 0.99634*width, y: 0.77517*height), control2: CGPoint(x: 0.7734*width, y: 0.99708*height))
            path.addCurve(to: CGPoint(x: 0.00366*width, y: 0.5*height), control1: CGPoint(x: 0.2266*width, y: 0.99708*height), control2: CGPoint(x: 0.00366*width, y: 0.77517*height))
            path.addCurve(to: CGPoint(x: 0.5*width, y: 0.00292*height), control1: CGPoint(x: 0.00366*width, y: 0.22483*height), control2: CGPoint(x: 0.2266*width, y: 0.00292*height))
            path.addCurve(to: CGPoint(x: 0.99634*width, y: 0.5*height), control1: CGPoint(x: 0.7734*width, y: 0.00292*height), control2: CGPoint(x: 0.99634*width, y: 0.22483*height))
            path.closeSubpath()
            return path
        }
}
