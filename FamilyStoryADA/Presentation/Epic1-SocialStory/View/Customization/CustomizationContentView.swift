//
//  CutomizationContentView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 01/11/24.
//

import SwiftUI
import AVKit

struct CustomizationContentView: View {
    @ObservedObject var viewModel: PageCustomizationViewModel
    @EnvironmentObject var keyboardHelper: KeyboardHelper
    @EnvironmentObject var cameraViewModel: CameraViewModel
    
    @State var currentText: String
    @Binding var isParaphrasingPresented: Bool
    @State var isLimitReached: Bool
    private let wordLimit = 15
    
    @State private var typingTimer: Timer? = nil
    
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        VStack{
            if let page = viewModel.selectedPage {
                VStack(alignment: .center, spacing: 32 * heightRatio) {
                    ZStack(alignment: .topTrailing) {
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
                        .highlight(
                            order: 3,
                            title: "Ganti Gambar",
                            description: "Ganti gambar yang disediakan dengan foto atau video sendiri.",
                            cornerRadius: 20 * heightRatio,
                            style: .circular,
                            position: .bottomLeading
                        )
                    }
                    ZStack {
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: Binding(
                                get: { currentText },
                                set: { newValue in
                                    let words = newValue.split(separator: " ")
                                    if words.count <= 15 {
                                        currentText = newValue
                                        isLimitReached = false
                                    } else {
                                        // Keep only the first 15 words
                                        currentText = words.prefix(15).joined(separator: " ")
                                        isLimitReached = true
                                        
                                        // Show feedback to user
                                        withAnimation {
                                            // Reset the limit reached state after a delay
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                isLimitReached = false
                                            }
                                        }
                                    }
                                    resetTypingTimer()
                                }
                            ))
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                            .padding(.horizontal, 19 * widthRatio)
                            .padding(.vertical, 15 * heightRatio)
                            .padding(.top, 24 * heightRatio) // Additional padding for word count
                            .frame(width: 760 * widthRatio, height: 168 * heightRatio)
                            .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("FSBlack"))
                            
                            if currentText.isEmpty {
                                Text("Masukkan teks di sini")
                                    .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("FSGrey").opacity(0.5))
                                    .padding(.horizontal, 19 * widthRatio)
                                    .padding(.vertical, 15 * heightRatio)
                                    .padding(.top, 28 * heightRatio)
                                    .allowsHitTesting(false)
                            }
                        }
                        .overlay(
                            Group {
                                if viewModel.selectedPage?.pageTextClassification == "Instructive" {
                                    TextBoxBackgroundView()
                                        .stroke(Color("FSPrimaryOrange5"), lineWidth: 2 * widthRatio)
                                } else if viewModel.selectedPage?.pageTextClassification == "Descriptive" {
                                    TextBoxBackgroundView()
                                        .stroke(Color(.fsBorderBlue7), lineWidth: 2 * widthRatio)
                                } else {
                                    TextBoxBackgroundView()
                                        .stroke(Color(.fsBlack), lineWidth: 2 * widthRatio)
                                }
                            }
                        )
                        .overlay(alignment: .topLeading) {
                            HStack(spacing: 4 * widthRatio) {
                                Text("\(wordCount)/15 kata")
                                    .font(Font.custom("Fredoka", size: 16 * widthRatio))
                                    .foregroundColor(isLimitReached ? Color("FSPrimaryOrange5") : Color("FSGrey"))
                                    .animation(.easeInOut(duration: 0.2), value: isLimitReached)
                                
                                if isLimitReached {
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .foregroundColor(Color("FSPrimaryOrange5"))
                                        .transition(.scale.combined(with: .opacity))
                                }
                            }
                            .padding(.horizontal, 20 * widthRatio)
                            .padding(.top, 8 * heightRatio)
                        }
                        .overlay(alignment: .bottomTrailing) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 40 * heightRatio)
                                    .foregroundStyle(.clear)
                                    .frame(width: 123 * widthRatio, height: 30 * heightRatio)
                                    .highlight(
                                        order: 5,
                                        title: "Gunakan AI",
                                        description: "Optimisasi konten menggunakan parafrase dengan AI.",
                                        cornerRadius: 40 * heightRatio,
                                        style: .continuous,
                                        position: .topCenter
                                    )
                                //TODO: Handle delay for paraphrasing
                                if (viewModel.selectedPage?.pageTextClassification == "Instructive" || viewModel.selectedPage?.pageTextClassification == "Descriptive"){
                                    Button(action: {
                                        isParaphrasingPresented = true
                                        viewModel.paraphraseModalIsLoading = true
                                        Task {
                                            do {
                                                let _ = try await viewModel.getParaphrasing(for: currentText)
                                                keyboardHelper.isKeyboardShown = false
                                                viewModel.paraphraseModalIsLoading = false
                                            } catch {
                                                print("Failed to fetch paraphrasing: \(error.localizedDescription)")
                                                viewModel.paraphraseModalIsLoading = false
                                            }
                                        }
                                    }, label: {
                                        HStack(spacing: 8 * widthRatio) {
                                            Image(systemName: "sparkles")
                                            Text("Optimalkan")
                                                .font(Font.custom("Fredoka", size: 16 * heightRatio))
                                                .fontWeight(.medium)
                                        }
                                        .foregroundStyle(Color(.fsBlue9))
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 40 * heightRatio)
                                                .strokeBorder(Color("FSBorderBlue7"), lineWidth: 2 * widthRatio)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 40 * heightRatio)
                                                        .fill(Color.white)
                                                )
                                        )
                                        .padding()
                                    })
                                }
                            }
                        }
                        .onAppear {
                            currentText = page.pageText.first?.componentContent ?? ""
                        }
                        .onChange(of: page.pageText.first?.componentContent) {
                            currentText = page.pageText.first?.componentContent ?? ""
                        }
                        .overlay(alignment: .topLeading) {
                            HStack {
                                if viewModel.selectedPage?.pageTextClassification == "Instructive" {
                                    Image(systemName: "exclamationmark.triangle")
                                        .font(Font.custom("Fredoka", size: 16 * heightRatio))
                                        .foregroundStyle(Color(.fsPrimaryOrange5))
                                    Text("Instruksional")
                                        .font(Font.custom("Fredoka", size: 16 * heightRatio))
                                        .foregroundStyle(Color(.fsPrimaryOrange5))
                                }
                                else if viewModel.selectedPage?.pageTextClassification == "Descriptive" {
                                    Image(systemName: "hand.thumbsup")
                                        .font(Font.custom("Fredoka", size: 16 * heightRatio))
                                        .foregroundStyle(Color(.fsBorderBlue7))
                                    Text("Deskriptif")
                                        .font(Font.custom("Fredoka", size: 16 * heightRatio))
                                        .foregroundStyle(Color(.fsBorderBlue7))
                                }
                            }
                            .padding(.top, 8 * heightRatio)
                            .padding(.leading, 136 * widthRatio)
                        }
                        RoundedRectangle(cornerRadius: 10 * heightRatio)
                            .foregroundStyle(.clear)
                            .frame(width: 760 * widthRatio, height: 170 * heightRatio)
                            .highlight(
                                order: 4,
                                title: "Edit Teks",
                                description: "Tekan untuk mengedit teks jika dibutuhkan dan atur sesuai kebiasaan anak.",
                                cornerRadius: 10 * heightRatio,
                                style: .continuous,
                                position: .topCenter
                            )
                    }
                    
                    
                }
                
                .disabled(isParaphrasingPresented)
                .offset(y: !viewModel.isGotoScrapImage && (keyboardHelper.isKeyboardShown || isParaphrasingPresented) ? -404 * heightRatio : 0)
            }
        }
        
    }
    
    private func resetTypingTimer() {
        typingTimer?.invalidate()
        typingTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            Task {
                do {
                    
                    let result = try await viewModel.getTextClassification(for: currentText)
                    // Uncomment to assign the result if needed
                    // currentText = result
                    await viewModel.selectedPage?.pageTextClassification = result.trimmingCharacters(in: .whitespacesAndNewlines)
                } catch {
                    print("Failed to fetch paraphrasing: \(error.localizedDescription)")
                    // Handle error here, possibly by setting an error message in viewModel
                }
            }
            updatePageText() // Call this after the async operation if order matters
        }
    }
    
    
    private var wordCount: Int {
        currentText.split(separator: " ").count
    }
    
    func updatePageText() {
        if let selectedPage = viewModel.selectedPage, !selectedPage.pageText.isEmpty {
            selectedPage.pageText.first?.componentContent = currentText
        } else {
            viewModel.selectedPage?.pageText = []
            viewModel.selectedPage?.pageText.append(TextComponentEntity(componentId: UUID(),
                                                                        componentContent: currentText,
                                                                        componentCategory: "Text"
                                                                       ))
        }
    }
}
