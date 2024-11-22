//
//  CustomizationMediaView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 22/11/24.
//

import SwiftUI
import AVFoundation

struct CustomizationMediaView: View {
    @ObservedObject var viewModel: PageCustomizationViewModel
    @EnvironmentObject var keyboardHelper: KeyboardHelper
    @EnvironmentObject var cameraViewModel: CameraViewModel
    @Binding var isParaphrasingPresented: Bool
    
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let page = viewModel.selectedPage {
                if page.pagePicture.first?.componentCategory == "AssetPicture", let imagePath = page.pagePicture.first?.componentContent {
                    
                    if (!viewModel.isGotoScrapImage && (keyboardHelper.isKeyboardShown || isParaphrasingPresented)) {
                        Image(imagePath)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 760 * widthRatio, height: 468 * heightRatio)
                            .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                            .mask(Rectangle().padding(.top, 390 * heightRatio))
                            .overlay(
                                VignetteEffectView()
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 12 * heightRatio)
                                    )
                            )
                    } else {
                        Image(imagePath)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 760 * widthRatio, height: 468 * heightRatio)
                            .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                            .overlay(
                                VignetteEffectView()
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 12 * heightRatio)
                                    )
                            )
                    }
                    
                } else if page.pagePicture.first?.componentCategory == "AppStoragePicture", let imagePath = page.pagePicture.first?.componentContent, let image = viewModel.loadImageFromDiskWith(fileName: imagePath) {
                    
                    if (!viewModel.isGotoScrapImage && (keyboardHelper.isKeyboardShown || isParaphrasingPresented)) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 760 * widthRatio, height: 468 * heightRatio)
                            .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                            .mask(Rectangle().padding(.top, 390 * heightRatio))
                            .overlay(
                                VignetteEffectView()
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 12 * heightRatio)
                                    )
                            )
                    } else {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 760 * widthRatio, height: 468 * heightRatio)
                            .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                            .overlay(
                                VignetteEffectView()
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 12 * heightRatio)
                                    )
                            )
                    }
                    
                } else if !page.pageVideo.isEmpty, let videoComponent = page.pageVideo.first, let url = Bundle.main.url(forResource: videoComponent.componentContent, withExtension: "mp4") {
                    
                    //                            let videoPlayer = AVPlayer(url: url)
                    
                    ZStack {
                        if (!viewModel.isGotoScrapImage && (keyboardHelper.isKeyboardShown || isParaphrasingPresented)) {
                            CustomVideoPlayerView(player: viewModel.videoPlayer, isReadyToPlay: $viewModel.isVideoReadyToPlay)
                                .frame(width: 760 * widthRatio, height: 468 * heightRatio)
                                .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                                .mask(Rectangle().padding(.top, 390 * heightRatio))
                                .overlay(
                                    VignetteEffectView()
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 12 * heightRatio)
                                        )
                                )
                                .onAppear() {
                                    viewModel.videoPlayer = AVPlayer(url: url)
                                    viewModel.videoPlayer.play()
                                }
                                .onDisappear() {
                                    viewModel.videoPlayer.pause()
                                }
                                .onChange(of: url) {
                                    viewModel.videoPlayer = AVPlayer(url: url)
                                    viewModel.videoPlayer.play()
                                }
                                .onTapGesture() {
                                    viewModel.videoPlayer.seek(to: .zero)
                                    viewModel.videoPlayer.play()
                                }
                        } else {
                            CustomVideoPlayerView(player: viewModel.videoPlayer, isReadyToPlay: $viewModel.isVideoReadyToPlay)
                                .frame(width: 760 * widthRatio, height: 468 * heightRatio)
                                .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                                .overlay(
                                    VignetteEffectView()
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 12 * heightRatio)
                                        )
                                )
                                .onAppear() {
                                    
                                    viewModel.videoPlayer = AVPlayer(url: url)
                                    viewModel.videoPlayer.play()
                                }
                                .onDisappear() {
                                    viewModel.videoPlayer.pause()
                                }
                                .onChange(of: url) {
                                    viewModel.videoPlayer = AVPlayer(url: url)
                                    viewModel.videoPlayer.play()
                                }
                                .onTapGesture() {
                                    viewModel.videoPlayer.seek(to: .zero)
                                    viewModel.videoPlayer.play()
                                }
                        }
                        
                        if !viewModel.isVideoReadyToPlay, let imagePath = page.pageVideo.first?.componentContent {
                            if (!viewModel.isGotoScrapImage && (keyboardHelper.isKeyboardShown || isParaphrasingPresented)) {
                                Image(imagePath)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 760 * widthRatio, height: 468 * heightRatio)
                                    .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                                    .mask(Rectangle().padding(.top, 390 * heightRatio))
                                    .overlay(
                                        VignetteEffectView()
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 12 * heightRatio)
                                            )
                                    )
                            } else {
                                Image(imagePath)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 760 * widthRatio, height: 468 * heightRatio)
                                    .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                                    .overlay(
                                        VignetteEffectView()
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 12 * heightRatio)
                                            )
                                    )
                            }
                        }
                    }
                } else {
                    Button(action: {
                        viewModel.isMediaOverlayOpened = true
                    }, label: {
                        EmptyImageCustomizationView(isParaphrasingPresented: $isParaphrasingPresented, viewModel: viewModel, widthRatio: widthRatio, heightRatio: heightRatio)
                    })
                }
                
                ZStack {
                    Circle()
                        .fill(.clear)
                        .frame(width: 52 * widthRatio, height: 52 * heightRatio)
                        .highlight(
                            order: 3,
                            title: "Ganti Gambar",
                            description: "Ganti gambar yang disediakan dengan foto atau video sendiri.",
                            cornerRadius: 40 * heightRatio,
                            style: .circular,
                            position: .bottomLeading
                        )
                    Menu {
                        Button(action: {
                            cameraViewModel.isPhotoCaptured = false
                            cameraViewModel.navigateToCamera = true
                        }) {
                            Label("Ambil Foto", systemImage: "camera")
                        }
                        
                        Button(action: {
                            cameraViewModel.isPhotoCaptured = false
                            cameraViewModel.showingImagePicker = true
                        }) {
                            Label("Pilih Foto", systemImage: "photo")
                        }
                        
                        Button(action: {
                            viewModel.isGotoScrapImage = true
                        }) {
                            Label("Cari Foto", systemImage: "photo.on.rectangle.angled")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 26 * heightRatio))
                            .fontWeight(.bold)
                            .foregroundStyle(Color("FSWhite"))
                            .padding()
                    }
                }
            }
        }
    }
}
