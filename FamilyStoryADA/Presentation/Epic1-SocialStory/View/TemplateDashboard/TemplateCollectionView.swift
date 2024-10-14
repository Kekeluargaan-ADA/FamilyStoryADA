//
//  TemplateCollectionView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 14/10/24.
//

import SwiftUI

struct TemplateCollectionView: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            VStack {
                Spacer()
                ZStack(alignment: .bottom) {
                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 40 * heightRatio, topTrailing: 40 * heightRatio))
                        .frame(height: 756 * heightRatio)
                        .foregroundStyle(.yellow)
                        .overlay(
                            VStack {
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
                                .padding(.horizontal, 46 * widthRatio)
                                .padding(.top, -32 * heightRatio)
                                ScrollView {
                                    LazyVGrid(columns: columns, spacing: 20 * heightRatio) {
                                        ForEach(0..<20, id: \.self) { _ in
                                            TemplateCardView()
                                                .scaleEffect(1 * heightRatio)
                                        }
                                    }
                                    .padding(46 * widthRatio)
                                    
                                }
                            }
                        )
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TemplateCollectionView()
}


