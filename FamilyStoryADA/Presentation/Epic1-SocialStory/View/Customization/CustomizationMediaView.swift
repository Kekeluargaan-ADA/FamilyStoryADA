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
                if let imagePath = page.pagePicture.first?.componentContent {
                    if page.pagePicture.first?.componentCategory == "AssetPicture" {
                        Image(imagePath)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 760 * widthRatio, height: 468 * heightRatio)
                            .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                            .applyMask(isKeyboardShown: keyboardHelper.isKeyboardShown, isParaphrasingPresented: isParaphrasingPresented, heightRatio: heightRatio)
                            .overlay(
                                VignetteEffectView()
                                    .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                            )
                    } else if page.pagePicture.first?.componentCategory == "AppStoragePicture",
                              let uiImage = viewModel.loadImageFromDiskWith(fileName: imagePath) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 760 * widthRatio, height: 468 * heightRatio)
                            .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                            .applyMask(isKeyboardShown: keyboardHelper.isKeyboardShown, isParaphrasingPresented: isParaphrasingPresented, heightRatio: heightRatio)
                            .overlay(
                                VignetteEffectView()
                                    .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                            )
                    }
                }
                else if !page.pageVideo.isEmpty, let videoComponent = page.pageVideo.first,
                        let url = Bundle.main.url(forResource: videoComponent.componentContent, withExtension: "mp4") {
                    ZStack {
                        CustomVideoPlayerView(player: viewModel.videoPlayer, isReadyToPlay: $viewModel.isVideoReadyToPlay)
                            .frame(width: 760 * widthRatio, height: 468 * heightRatio)
                            .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                            .applyMask(isKeyboardShown: keyboardHelper.isKeyboardShown, isParaphrasingPresented: isParaphrasingPresented, heightRatio: heightRatio)
                            .overlay(
                                VignetteEffectView()
                                    .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                            )
                            .onAppear {
                                viewModel.videoPlayer = AVPlayer(url: url)
                                viewModel.videoPlayer.play()
                            }
                            .onDisappear {
                                viewModel.videoPlayer.pause()
                            }
                            .onTapGesture {
                                viewModel.videoPlayer.seek(to: .zero)
                                viewModel.videoPlayer.play()
                            }
                        
                        if !viewModel.isVideoReadyToPlay, let fallbackImage = page.pageVideo.first?.componentContent {
                            Image(fallbackImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 760 * widthRatio, height: 468 * heightRatio)
                                .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                                .applyMask(isKeyboardShown: keyboardHelper.isKeyboardShown, isParaphrasingPresented: isParaphrasingPresented, heightRatio: heightRatio)
                                .overlay(
                                    VignetteEffectView()
                                        .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                                )
                        }
                    }
                }
                else {
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

extension View {
    func applyMask(isKeyboardShown: Bool, isParaphrasingPresented: Bool, heightRatio: CGFloat) -> some View {
        Group {
            if isKeyboardShown || isParaphrasingPresented {
                self.mask(Rectangle().padding(.top, 390 * heightRatio))
            } else {
                self
            }
        }
    }
}
