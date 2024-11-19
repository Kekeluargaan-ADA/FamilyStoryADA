//
//  MyIcon.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 16/10/24.
//

import SwiftUI


struct StoryDashboardBackgroundView: Shape {
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = 1146 * widthRatio
        let height = 1041 * heightRatio
        
        path.move(to: CGPoint(x: 0.00347*width, y: 0.99237*height))
        path.addLine(to: CGPoint(x: 0.99653*width, y: 0.99237*height))
        path.addLine(to: CGPoint(x: 0.99653*width, y: 0.11439*height))
        path.addCurve(to: CGPoint(x: 0.97227*width, y: 0.0877*height), control1: CGPoint(x: 0.99653*width, y: 0.09965*height), control2: CGPoint(x: 0.98567*width, y: 0.0877*height))
        path.addLine(to: CGPoint(x: 0.00347*width, y: 0.0877*height))
        path.addLine(to: CGPoint(x: 0.00347*width, y: 0.99237*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.00347*width, y: 0.02669*height))
        path.addCurve(to: CGPoint(x: 0.02773*width, y: 0), control1: CGPoint(x: 0.00347*width, y: 0.01195*height), control2: CGPoint(x: 0.01433*width, y: 0))
        path.addLine(to: CGPoint(x: 0.21317*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.23744*width, y: 0.02669*height), control1: CGPoint(x: 0.22657*width, y: 0), control2: CGPoint(x: 0.23744*width, y: 0.01195*height))
        path.addLine(to: CGPoint(x: 0.23744*width, y: 0.0877*height))
        path.addLine(to: CGPoint(x: 0.00347*width, y: 0.0877*height))
        path.addLine(to: CGPoint(x: 0.00347*width, y: 0.02669*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.23744*width, y: 0.05816*height))
        path.addCurve(to: CGPoint(x: 0.26435*width, y: 0.0877*height), control1: CGPoint(x: 0.23747*width, y: 0.07448*height), control2: CGPoint(x: 0.24951*width, y: 0.0877*height))
        path.addCurve(to: CGPoint(x: 0.26516*width, y: 0.08769*height), control1: CGPoint(x: 0.26462*width, y: 0.0877*height), control2: CGPoint(x: 0.26489*width, y: 0.0877*height))
        path.addLine(to: CGPoint(x: 0.26516*width, y: 0.0877*height))
        path.addLine(to: CGPoint(x: 0.23744*width, y: 0.0877*height))
        path.addLine(to: CGPoint(x: 0.23744*width, y: 0.05816*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.23744*width, y: 0.05802*height))
        path.addCurve(to: CGPoint(x: 0.23745*width, y: 0.0572*height), control1: CGPoint(x: 0.23744*width, y: 0.05775*height), control2: CGPoint(x: 0.23744*width, y: 0.05747*height))
        path.addLine(to: CGPoint(x: 0.23744*width, y: 0.0572*height))
        path.addLine(to: CGPoint(x: 0.23744*width, y: 0.05802*height))
        path.closeSubpath()
        return path
    }
}
