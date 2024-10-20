//
//  LibraryPreviewModality.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 14/10/24.
//

import SwiftUI

struct PagePreviewModalView: View {
    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            Rectangle()
                .foregroundStyle(Color("FSBlue1"))
                .frame(width: 728 * widthRatio, height: 743 * heightRatio)
                .cornerRadius(20 * heightRatio)
                .overlay(
                    VStack {
                        HStack {
                            ZStack {
                                HStack {
                                    ButtonCircle(heightRatio: heightRatio, buttonImage: "xmark", buttonColor: .blue)
                                    Spacer()
                                }
                                Text("Cara Menyikat Gigi")
                                    .font(.system(size: 32 * heightRatio))
                                    .fontWeight(.bold)
                            }
                        }
                        Spacer().frame(height: 24 * heightRatio)
                        BriefSquareView(heightRatio: heightRatio, widthRatio: widthRatio)
                        Spacer().frame(height: 24 * heightRatio)
                        ScrollView {
                            LazyVGrid(
                                columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)],
                                spacing: 16 * heightRatio                    ) {
                                    ForEach(1...6, id: \.self) { step in
                                        StepsSquareView(heightRatio: heightRatio, widthRatio: widthRatio)
                                    }
                                }
                        }
                        .padding(.horizontal, 45 * widthRatio)
                    }
                    .padding(24 * heightRatio)
                )

        }
    }
}

#Preview {
    PagePreviewModalView()
}
