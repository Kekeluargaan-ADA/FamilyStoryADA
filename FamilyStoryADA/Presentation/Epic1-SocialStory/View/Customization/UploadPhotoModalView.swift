//
//  UploadPhotoModalView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 17/10/24.
//

import SwiftUI

struct UploadPhotoModalView: View {
    @State private var isModalPresented = false
    
    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 0.96, green: 0.99, blue: 0.99))
                    .frame(width: 728 * widthRatio, height: 352 * heightRatio)
                    .cornerRadius(20 * heightRatio)
                    .overlay(
                        VStack {
                            HStack {
                                ZStack {
                                    HStack {
                                        Button(action: {
                                            
                                        }, label: {
                                            ButtonCircle(heightRatio: heightRatio, buttonImage: "xmark", buttonColor: .blue)
                                        })
                                        Spacer()
                                    }
                                    Text("Upload Foto")
                                        .font(.system(size: 32 * heightRatio))
                                        .fontWeight(.bold)
                                }
                            }
                            Spacer().frame(height: 36 * heightRatio)
                            HStack(spacing: 24 * widthRatio) {
                                ButtonSquare(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "camera", text: "Kamera", onTap: {})
                                ButtonSquare(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "photo", text: "Galeri", onTap: {})
                                ButtonSquare(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "photo.on.rectangle.angled", text: "Generate", onTap: {})
                            }
                            Spacer()
                        }
                            .padding(24 * heightRatio)
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    UploadPhotoModalView()
}
