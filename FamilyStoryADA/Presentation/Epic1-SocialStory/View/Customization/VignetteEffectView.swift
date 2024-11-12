//
//  VignetteEffectView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 05/11/24.
//

import SwiftUI

struct VignetteEffectView: View {
    var body: some View {
//        ZStack {
//            LinearGradient(
//                gradient: Gradient(stops: [
//                        .init(color: Color.black.opacity(0.2), location: 0.0),
//                        .init(color: Color.clear, location: 0.3)
//                    ]),
//                    startPoint: .top,
//                    endPoint: .bottom
//            )
//            .clipShape(RoundedRectangle(cornerRadius: 12))
//            LinearGradient(
//                gradient: Gradient(stops: [
//                        .init(color: Color.black.opacity(0.2), location: 0.0),
//                        .init(color: Color.clear, location: 0.1)
//                    ]),
//                    startPoint: .top,
//                    endPoint: .bottom
//            )
//            .clipShape(RoundedRectangle(cornerRadius: 12))
//        }
        LinearGradient(
              stops: [
                Gradient.Stop(color: Color(red: 0.45, green: 0.45, blue: 0.45).opacity(0.4), location: 0.0),
                Gradient.Stop(color: Color(red: 0.64, green: 0.64, blue: 0.64).opacity(0.16), location: 0.09),
                Gradient.Stop(color: Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0), location: 0.17),
              ],
              startPoint: .top,
              endPoint: .bottom
            )
    }
}

#Preview {
    VignetteEffectView()
}
