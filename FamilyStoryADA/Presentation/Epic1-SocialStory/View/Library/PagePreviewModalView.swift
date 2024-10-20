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
            }
        }
    }
}


#Preview {
    PagePreviewModalView()
}
