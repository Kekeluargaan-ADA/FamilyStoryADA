
//
//  ScrappingInitialView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 18/10/24.
//

import SwiftUI

struct ScrappingInitialView: View {
    @State private var isModalPresented = false
    @StateObject private var crawlViewModel = ImageCrawlViewModel()
    @EnvironmentObject var viewModel: PageCustomizationViewModel
    @EnvironmentObject var cameraViewModel: CameraViewModel
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    @AppStorage("selectedImageUUID") var selectedImageUUID: String?
    
    var body: some View {
        GeometryReader { geometry in
            let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
            let heightRatio = ratios.heightRatio
            let widthRatio = ratios.widthRatio
            
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 0.96, green: 0.99, blue: 0.99))
                    .frame(width: 728 * widthRatio, height: 743 * heightRatio)
                    .cornerRadius(20 * heightRatio)
                    .overlay(
                        VStack {
                            HStack(alignment: .top) {
                                ZStack {
                                    HStack {
                                        Button(action: {
                                            crawlViewModel.deleteImages()
                                            viewModel.isGotoScrapImage = false
                                        }) {
                                            ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "chevron.left", buttonColor: .blue)
                                        }
                                        Spacer()
                                    }
                                    Text("Cari Foto")
                                        .font(Font.custom("Fredoka", size: 32 * heightRatio))
                                        .foregroundStyle(Color("FSBlack"))
                                        .fontWeight(.bold)
                                }
                            }
                            HStack {
                                SearchBarView(searchText: $crawlViewModel.keyword, onCommit: {
                                    crawlViewModel.deleteImages()
                                    crawlViewModel.crawlImages()
                                }, searchPlaceholder: "Cari")
                                Button(action: {
                                    crawlViewModel.deleteImages()
                                    crawlViewModel.crawlImages()
                                }, label: {
                                    ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "arrow.clockwise", buttonColor: .blue)
                                })
                            }
                            .zIndex(1)
                            if !networkMonitor.isConnected {
                                Spacer().frame(height: 124)
                                LostConnectionView()
                                    .foregroundStyle(Color("FSBorderBlue7"))
                                    .frame(width: 127.65, height: 127.65)
                                Spacer().frame(height: 32)
                                Text("Koneksi hilang")
                                    .font(Font.custom("Fredoka", size: 24).weight(.medium))
                                    .foregroundColor(Color("FSBorderBlue7"))
                                Spacer().frame(height: 8)
                                Text("Cek koneksi internet dan coba lagi.")
                                    .font(Font.custom("Fredoka", size: 20))
                                    .foregroundColor(Color("FSBorderBlue7"))
                                Spacer()
                            } else if crawlViewModel.isLoading {
                                LottieView(animationName: "load-state-icon", width: 68, height: 72)
                                Spacer()
                            } else if crawlViewModel.processedImages.isEmpty {
                                Spacer().frame(height: 100)
                                ImageSearchView()
                                    .frame(width: 152, height: 131.25)
                                    .foregroundStyle(Color("FSBorderBlue7"))
                                Spacer().frame(height: 8)
                                Text("Masih kosong, nih")
                                    .font(Font.custom("Fredoka", size: 24).weight(.medium))
                                    .foregroundStyle(Color("FSBorderBlue7"))
                                Spacer().frame(height: 8)
                                Text("Masukkan kata kunci yang sesuai untuk\nmenampilkan hasil.")
                                    .font(Font.custom("Fredoka", size: 20))
                                    .foregroundStyle(Color("FSBorderBlue7"))
                                Spacer()
                            } else if crawlViewModel.isImageUnprocessable {
                                Spacer().frame(height: 100)
                                ImageNoResultView()
                                    .frame(width: 152, height: 131.25)
                                    .foregroundStyle(Color("FSBorderBlue7"))
                                Spacer().frame(height: 8)
                                Text("Ups, tidak ada hasil")
                                    .font(Font.custom("Fredoka", size: 24).weight(.medium))
                                    .foregroundColor(Color("FSBorderBlue7"))
                                Spacer().frame(height: 8)
                                Text("Coba masukkan kata kunci lain.")
                                    .font(Font.custom("Fredoka", size: 20))
                                    .foregroundColor(Color("FSBorderBlue7"))
                                Spacer()
                            } else {
                                LazyVGrid(
                                    columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3),
                                    spacing: 10
                                ) {
                                    ForEach(crawlViewModel.processedImages.prefix(6), id: \.self) { image in
                                        GridItemView(
                                            image: image,
                                            isSelected: crawlViewModel.selectedImage == image,
                                            onTap: {
                                                crawlViewModel.selectedImage = image
                                            },
                                            heightRatio:  heightRatio,
                                            widthRatio:  widthRatio
                                        )
                                    }
                                }
                                .frame(width: 666 * widthRatio, height: 284 * heightRatio)
                                Spacer()
                                Button(action: {
                                    if let selectedImage = crawlViewModel.selectedImage {
                                        cameraViewModel.savedImage = selectedImage
                                        cameraViewModel.isPhotoCaptured = true
                                        crawlViewModel.deleteImages()
                                        viewModel.isGotoScrapImage = false
                                    }
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 160, height: 60)
                                            .foregroundStyle(Color("FSBlue9"))
                                            .cornerRadius(40)
                                            .overlay(
                                                Text("Pilih")
                                                    .foregroundColor(.white)
                                            )
                                    }
                                }
                            }
                        }
                            .padding(24 * heightRatio)
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct GridItemView: View {
    let image: UIImage
    let isSelected: Bool
    let onTap: () -> Void
    let heightRatio: Double
    let widthRatio: Double
    var body: some View {
            
            Button(action: onTap) {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 214 * widthRatio, height: 132 * heightRatio)
                        .clipped()
                        .cornerRadius(12)
                        .shadow(radius: 2, y: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12 * heightRatio)
                                .stroke(isSelected ? Color("FSBlue9") : Color.clear, lineWidth: 2 * heightRatio)
                        )
                    if isSelected {
                        ZStack {
                            Circle()
                                .foregroundStyle(Color("FSWhite"))
                                .frame(width: 20 * widthRatio, height: 20 * heightRatio)
                            Image(systemName: "checkmark.circle")
                                .foregroundStyle(Color("FSBlue9"))
                                .font(.system(size: 20 * heightRatio))
                                .bold()
                        }
                        .position(x: 214 * widthRatio - 17 * widthRatio, y: 17 * heightRatio)
                    }
                }
        }
    }
}


