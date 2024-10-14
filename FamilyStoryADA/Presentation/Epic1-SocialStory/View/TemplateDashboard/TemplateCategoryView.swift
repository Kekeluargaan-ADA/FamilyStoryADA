//
//  TemplateCategoryView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//

import SwiftUI

struct TemplateCategoryView: View {
    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            HStack(spacing: 0) {
                Circle()
                    .foregroundStyle(.gray)
                    .frame(height: 64)
                Spacer()
                Circle()
                    .foregroundStyle(.gray)
                    .frame(height: 64)
                Circle()
                    .foregroundStyle(.gray)
                    .frame(height: 64)
                Circle()
                    .foregroundStyle(.gray)
                    .frame(height: 64)
                Circle()
                    .foregroundStyle(.gray)
                    .frame(height: 64)
            }
        }
    }
}

#Preview {
    TemplateCategoryView()
}
