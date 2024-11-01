//
//  UploadPhotoModalView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 17/10/24.
//

import SwiftUI

struct UploadPhotoModalView: View {
    @EnvironmentObject var viewModel: PageCustomizationViewModel
    @EnvironmentObject var cameraViewModel: CameraViewModel
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
                                            viewModel.isMediaOverlayOpened = false
                                        }, label: {
                                            ButtonCircle(heightRatio: heightRatio, buttonImage: "xmark", buttonColor: .blue)
                                        })
                                        Spacer()
                                    }
                                    Text("Upload Foto")
                                        .foregroundStyle(Color("FSBlack"))
                                        .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color("FSBlack"))
                                }
                            }
                            Spacer().frame(height: 36 * heightRatio)
                            HStack(spacing: 24 * widthRatio) {
                                ButtonSquare(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "camera", text: "Kamera", onTap: {
                                    cameraViewModel.isPhotoCaptured = false
                                    cameraViewModel.navigateToCamera = true
                                })
                                ButtonSquare(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "photo", text: "Galeri", onTap: {
                                    cameraViewModel.isPhotoCaptured = false
                                    cameraViewModel.showingImagePicker = true
                                })
                                ButtonSquare(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "photo.on.rectangle.angled", text: "Cari Foto", onTap: {
                                    viewModel.isGotoScrapImage = true
                                })
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
