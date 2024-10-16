//
//  MyIcon.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 16/10/24.
//

import SwiftUI


struct StoryDashboardBackgroundView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.00347*width, y: 0.99015*height))
        path.addLine(to: CGPoint(x: 0.99653*width, y: 0.99015*height))
        path.addLine(to: CGPoint(x: 0.99653*width, y: 0.14778*height))
        path.addCurve(to: CGPoint(x: 0.97227*width, y: 0.1133*height), control1: CGPoint(x: 0.99653*width, y: 0.12874*height), control2: CGPoint(x: 0.98567*width, y: 0.1133*height))
        path.addLine(to: CGPoint(x: 0.00347*width, y: 0.1133*height))
        path.addLine(to: CGPoint(x: 0.00347*width, y: 0.99015*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.00347*width, y: 0.03448*height))
        path.addCurve(to: CGPoint(x: 0.02773*width, y: 0), control1: CGPoint(x: 0.00347*width, y: 0.01544*height), control2: CGPoint(x: 0.01433*width, y: 0))
        path.addLine(to: CGPoint(x: 0.21317*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.23744*width, y: 0.03448*height), control1: CGPoint(x: 0.22657*width, y: 0), control2: CGPoint(x: 0.23744*width, y: 0.01544*height))
        path.addLine(to: CGPoint(x: 0.23744*width, y: 0.1133*height))
        path.addLine(to: CGPoint(x: 0.00347*width, y: 0.1133*height))
        path.addLine(to: CGPoint(x: 0.00347*width, y: 0.03448*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.23744*width, y: 0.07514*height))
        path.addCurve(to: CGPoint(x: 0.26435*width, y: 0.1133*height), control1: CGPoint(x: 0.23747*width, y: 0.09622*height), control2: CGPoint(x: 0.24951*width, y: 0.1133*height))
        path.addCurve(to: CGPoint(x: 0.26516*width, y: 0.11328*height), control1: CGPoint(x: 0.26462*width, y: 0.1133*height), control2: CGPoint(x: 0.26489*width, y: 0.11329*height))
        path.addLine(to: CGPoint(x: 0.26516*width, y: 0.1133*height))
        path.addLine(to: CGPoint(x: 0.23744*width, y: 0.1133*height))
        path.addLine(to: CGPoint(x: 0.23744*width, y: 0.07514*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.23744*width, y: 0.07496*height))
        path.addCurve(to: CGPoint(x: 0.23745*width, y: 0.07389*height), control1: CGPoint(x: 0.23744*width, y: 0.0746*height), control2: CGPoint(x: 0.23744*width, y: 0.07425*height))
        path.addLine(to: CGPoint(x: 0.23744*width, y: 0.07389*height))
        path.addLine(to: CGPoint(x: 0.23744*width, y: 0.07496*height))
        path.closeSubpath()
        return path
    }
}
