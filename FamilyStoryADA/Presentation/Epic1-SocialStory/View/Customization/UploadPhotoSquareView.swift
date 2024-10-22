//
//  UploadPhotoPage.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 17/10/24.
//

import SwiftUI

struct UploadPhotoSquareView: View {
    @State private var isModalPresented = false

    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            ZStack {
                Button(action: {
                    withAnimation {
                        isModalPresented.toggle()
                    }
                }) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 760 * widthRatio, height: 468 * heightRatio)
                        .cornerRadius(12)
                        .shadow(radius: 2, y: 4)
                        .overlay(
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 1)
                                    .stroke(Color("FSBorderBlue7"))
                                VStack {
                                    Image(systemName: "photo")
                                        .foregroundStyle(Color("FSBlue9"))
                                        .font(.system(size: 26 * heightRatio))
                                        .bold()
                                    Spacer().frame(height: 8 * heightRatio)
                                    Text("Upload Foto")
                                        .font(.system(size: 24 * heightRatio))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("FSBlue9"))
                                }
                            }
                        )
                }
                .buttonStyle(.plain)
                if isModalPresented {
                    
                    UploadPhotoModalView()

                }
            }
        }
    }
}

#Preview {
    UploadPhotoSquareView()
}
