//
//  MyIcon.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import SwiftUICore


struct BackgroundCustomizationView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.00404*width, y: 0.03544*height))
        path.addCurve(to: CGPoint(x: 0.03236*width, y: 0), control1: CGPoint(x: 0.00404*width, y: 0.01587*height), control2: CGPoint(x: 0.01672*width, y: 0))
        path.addLine(to: CGPoint(x: 0.99596*width, y: 0))
        path.addLine(to: CGPoint(x: 0.99596*width, y: 0.98987*height))
        path.addLine(to: CGPoint(x: 0.03236*width, y: 0.98987*height))
        path.addCurve(to: CGPoint(x: 0.00404*width, y: 0.95443*height), control1: CGPoint(x: 0.01672*width, y: 0.98987*height), control2: CGPoint(x: 0.00404*width, y: 0.97401*height))
        path.addLine(to: CGPoint(x: 0.00404*width, y: 0.03544*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.34783*width, y: 0))
        path.addLine(to: CGPoint(x: 0.65116*width, y: 0))
        path.addLine(to: CGPoint(x: 0.65116*width, y: 0.04051*height))
        path.addCurve(to: CGPoint(x: 0.62285*width, y: 0.07595*height), control1: CGPoint(x: 0.65116*width, y: 0.06008*height), control2: CGPoint(x: 0.63849*width, y: 0.07595*height))
        path.addLine(to: CGPoint(x: 0.37614*width, y: 0.07595*height))
        path.addCurve(to: CGPoint(x: 0.34783*width, y: 0.04051*height), control1: CGPoint(x: 0.3605*width, y: 0.07595*height), control2: CGPoint(x: 0.34783*width, y: 0.06008*height))
        path.addLine(to: CGPoint(x: 0.34783*width, y: 0))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.65116*width, y: 0.03433*height))
        path.addCurve(to: CGPoint(x: 0.67849*width, y: 0), control1: CGPoint(x: 0.65119*width, y: 0.01542*height), control2: CGPoint(x: 0.6634*width, y: 0.0001*height))
        path.addLine(to: CGPoint(x: 0.65116*width, y: 0))
        path.addLine(to: CGPoint(x: 0.65116*width, y: 0.03433*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.67879*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.67947*width, y: 0.00001*height), control1: CGPoint(x: 0.67902*width, y: 0), control2: CGPoint(x: 0.67925*width, y: 0.00001*height))
        path.addLine(to: CGPoint(x: 0.67947*width, y: 0))
        path.addLine(to: CGPoint(x: 0.67879*width, y: 0))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.65116*width, y: 0.03447*height))
        path.addLine(to: CGPoint(x: 0.65116*width, y: 0.03544*height))
        path.addLine(to: CGPoint(x: 0.65117*width, y: 0.03544*height))
        path.addCurve(to: CGPoint(x: 0.65116*width, y: 0.03447*height), control1: CGPoint(x: 0.65117*width, y: 0.03512*height), control2: CGPoint(x: 0.65116*width, y: 0.0348*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.34783*width, y: 0.03433*height))
        path.addCurve(to: CGPoint(x: 0.3205*width, y: 0), control1: CGPoint(x: 0.34779*width, y: 0.01542*height), control2: CGPoint(x: 0.33559*width, y: 0.0001*height))
        path.addLine(to: CGPoint(x: 0.34783*width, y: 0))
        path.addLine(to: CGPoint(x: 0.34783*width, y: 0.03433*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.3202*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.31951*width, y: 0.00001*height), control1: CGPoint(x: 0.31997*width, y: 0), control2: CGPoint(x: 0.31974*width, y: 0.00001*height))
        path.addLine(to: CGPoint(x: 0.31951*width, y: 0))
        path.addLine(to: CGPoint(x: 0.3202*width, y: 0))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.34783*width, y: 0.03447*height))
        path.addLine(to: CGPoint(x: 0.34783*width, y: 0.03544*height))
        path.addLine(to: CGPoint(x: 0.34781*width, y: 0.03544*height))
        path.addCurve(to: CGPoint(x: 0.34783*width, y: 0.03447*height), control1: CGPoint(x: 0.34782*width, y: 0.03512*height), control2: CGPoint(x: 0.34783*width, y: 0.0348*height))
        path.closeSubpath()
        path.addRect(CGRect(x: 0.364*width, y: 0.00633*height, width: 0.27098*width, height: 0.05696*height))
        return path
    }
}
