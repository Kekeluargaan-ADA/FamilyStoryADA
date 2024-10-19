//
//  EmptyImageCustomizationView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 17/10/24.
//

import SwiftUI

struct EmptyImageCustomizationView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("FSWhite").shadow(.drop(radius: 4, x: 0, y: 4)))
                .strokeBorder(Color("FSBorderBlue7"), lineWidth: 2)
                
            VStack(spacing: 8) {
                Image(systemName: "photo")
                    .font(.system(size: 36))
                    .foregroundStyle(Color("FSBlue9"))
                Text("Upload Photo")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(Color("FSBlue9"))
            }
        }
        .frame(width: 760, height: 468)
    }
}

#Preview {
    EmptyImageCustomizationView()
}
