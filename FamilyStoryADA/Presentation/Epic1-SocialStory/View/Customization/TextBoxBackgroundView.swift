//
//  TextBoxBackgroundView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 29/10/24.
//

import SwiftUI

struct TextBoxBackgroundView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.98177*width, y: 0.21335*height))
        path.addLine(to: CGPoint(x: 0.1863*width, y: 0.21335*height))
        path.addCurve(to: CGPoint(x: 0.16547*width, y: 0.12244*height), control1: CGPoint(x: 0.17479*width, y: 0.21335*height), control2: CGPoint(x: 0.16547*width, y: 0.17267*height))
        path.addLine(to: CGPoint(x: 0.16547*width, y: 0.09091*height))
        path.addCurve(to: CGPoint(x: 0.14464*width, y: 0), control1: CGPoint(x: 0.16547*width, y: 0.04068*height), control2: CGPoint(x: 0.15615*width, y: 0))
        path.addLine(to: CGPoint(x: 0.02604*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.00521*width, y: 0.09091*height), control1: CGPoint(x: 0.01453*width, y: 0), control2: CGPoint(x: 0.00521*width, y: 0.04068*height))
        path.addLine(to: CGPoint(x: 0.00521*width, y: 0.89773*height))
        path.addCurve(to: CGPoint(x: 0.01823*width, y: 0.95455*height), control1: CGPoint(x: 0.00521*width, y: 0.92909*height), control2: CGPoint(x: 0.01104*width, y: 0.95455*height))
        path.addLine(to: CGPoint(x: 0.98177*width, y: 0.95455*height))
        path.addCurve(to: CGPoint(x: 0.99479*width, y: 0.89773*height), control1: CGPoint(x: 0.98896*width, y: 0.95455*height), control2: CGPoint(x: 0.99479*width, y: 0.92909*height))
        path.addLine(to: CGPoint(x: 0.99479*width, y: 0.27017*height))
        path.addCurve(to: CGPoint(x: 0.98177*width, y: 0.21335*height), control1: CGPoint(x: 0.99479*width, y: 0.23881*height), control2: CGPoint(x: 0.98896*width, y: 0.21335*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.1863*width, y: 0.21903*height))
        path.addLine(to: CGPoint(x: 0.98177*width, y: 0.21903*height))
        path.addCurve(to: CGPoint(x: 0.99349*width, y: 0.27017*height), control1: CGPoint(x: 0.98824*width, y: 0.21903*height), control2: CGPoint(x: 0.99349*width, y: 0.24194*height))
        path.addLine(to: CGPoint(x: 0.99349*width, y: 0.89773*height))
        path.addCurve(to: CGPoint(x: 0.98177*width, y: 0.94886*height), control1: CGPoint(x: 0.99349*width, y: 0.92595*height), control2: CGPoint(x: 0.98824*width, y: 0.94886*height))
        path.addLine(to: CGPoint(x: 0.01823*width, y: 0.94886*height))
        path.addCurve(to: CGPoint(x: 0.00651*width, y: 0.89773*height), control1: CGPoint(x: 0.01176*width, y: 0.94886*height), control2: CGPoint(x: 0.00651*width, y: 0.92595*height))
        path.addLine(to: CGPoint(x: 0.00651*width, y: 0.09091*height))
        path.addCurve(to: CGPoint(x: 0.02604*width, y: 0.00568*height), control1: CGPoint(x: 0.00651*width, y: 0.04382*height), control2: CGPoint(x: 0.01525*width, y: 0.00568*height))
        path.addLine(to: CGPoint(x: 0.14464*width, y: 0.00568*height))
        path.addCurve(to: CGPoint(x: 0.16417*width, y: 0.09091*height), control1: CGPoint(x: 0.15543*width, y: 0.00568*height), control2: CGPoint(x: 0.16417*width, y: 0.04382*height))
        path.addLine(to: CGPoint(x: 0.16417*width, y: 0.12244*height))
        path.addCurve(to: CGPoint(x: 0.1863*width, y: 0.21903*height), control1: CGPoint(x: 0.16417*width, y: 0.17581*height), control2: CGPoint(x: 0.17407*width, y: 0.21903*height))
        path.closeSubpath()
        return path
    }
}
