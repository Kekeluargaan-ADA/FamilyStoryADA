//
//  MyIcon.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import SwiftUICore
import SwiftUI

struct CustomizedBackButton: View {
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        ZStack(alignment: .center) {
            BackButtonBackground()
                .fill(Color("FSSecondaryBlue4").shadow(.drop(color: Color(.fsBlack).opacity(0.1), radius: 4, y: 4 * heightRatio)))
            HStack (alignment: .center, spacing: 21 * widthRatio) {
                Image(systemName: "arrowshape.turn.up.backward")
                    .font(.system(size: 36 * heightRatio))
                    .fontWeight(.medium)
                    .foregroundStyle(Color("FSBlack"))
                Text("Ceritaku")
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .font(Font.custom("Fredoka", size: 24 * heightRatio, relativeTo: .title2))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("FSBlack"))
                    
            }
            .padding(.leading, 21 * widthRatio)
            .padding(.trailing, 11 * widthRatio)
            .padding(.vertical, 28 * heightRatio)
        }
        .frame(width: 197 * widthRatio, height: 100 * heightRatio)
    }
    
}

#Preview {
    CustomizedBackButton(widthRatio: 1, heightRatio: 1)
}

struct BackButtonBackground: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.9801*width, y: 0.25926*height))
        path.addCurve(to: CGPoint(x: 0.8408*width, y: 0), control1: CGPoint(x: 0.9801*width, y: 0.11607*height), control2: CGPoint(x: 0.91773*width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0.92593*height))
        path.addLine(to: CGPoint(x: 0.8408*width, y: 0.92593*height))
        path.addCurve(to: CGPoint(x: 0.9801*width, y: 0.66667*height), control1: CGPoint(x: 0.91773*width, y: 0.92593*height), control2: CGPoint(x: 0.9801*width, y: 0.80985*height))
        path.addLine(to: CGPoint(x: 0.9801*width, y: 0.25926*height))
        path.closeSubpath()
        return path
    }
}
