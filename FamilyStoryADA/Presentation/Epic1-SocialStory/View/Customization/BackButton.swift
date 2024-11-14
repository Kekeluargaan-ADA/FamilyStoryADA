//
//  MyIcon.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import SwiftUICore
import SwiftUI

struct CustomizedBackButton: View {
    
    var body: some View {
        ZStack(alignment: .center) {
            BackButtonBackground()
                .fill(Color("FSSecondaryBlue4"))
            HStack (spacing: 21) {
                Image(systemName: "arrowshape.turn.up.backward")
                    .resizable()
                    .frame(width: 45, height: 43)
                    .foregroundStyle(Color("FSBlack"))
                Text("Ceritaku")
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .font(Font.custom("Fredoka", size: 24, relativeTo: .title2))
                    .foregroundStyle(Color("FSBlack"))
                    
            }
            .padding(.leading, 21)
            .padding(.trailing, 11)
            .padding(.vertical, 21)
        }
        .frame(width: 197, height: 100)
    }
    
}

#Preview {
    CustomizedBackButton()
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
