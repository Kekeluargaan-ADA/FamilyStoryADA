
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
    
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    
    var body: some View {
        VStack{
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
                                if !crawlViewModel.isLoading{
                                    crawlViewModel.isLoading = true
                                    crawlViewModel.deleteImages()
                                    crawlViewModel.crawlImages()
                                }
                            }, searchPlaceholder: "Cari", widthRatio: widthRatio, heightRatio: heightRatio)
                            Button(action: {
                                if !crawlViewModel.isLoading{
                                    crawlViewModel.isLoading = true
                                    crawlViewModel.deleteImages()
                                    crawlViewModel.crawlImages()
                                }
                            }, label: {
                                ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "arrow.clockwise", buttonColor: .blue)
                            })
                        }
                        .zIndex(1)
                        if !networkMonitor.isConnected {
                            Spacer().frame(height: 124 * heightRatio)
                            LostConnectionView(widthRatio: widthRatio, heightRatio: heightRatio)
                                .foregroundStyle(Color("FSBorderBlue7"))
                                .frame(width: 132 * widthRatio, height: 132 * heightRatio)
                            Spacer().frame(height: 32 * heightRatio)
                            Text("Koneksi hilang")
                                .font(Font.custom("Fredoka", size: 24 * heightRatio).weight(.medium))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("FSBorderBlue7"))
                            Spacer().frame(height: 8 * heightRatio)
                            Text("Cek koneksi internet dan coba lagi.")
                                .font(Font.custom("Fredoka", size: 20 * heightRatio))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("FSBorderBlue7"))
                            Spacer()
                        } else if crawlViewModel.isLoading {
                            LottieView(animationName: "load-state-icon", width: 68 * widthRatio, height: 72 * heightRatio)
                            Spacer()
                        } else if crawlViewModel.processedImages.isEmpty {
                            Spacer().frame(height: 100 * heightRatio)
                            ImageSearchView(widthRatio: widthRatio, heightRatio: heightRatio)
                                .frame(width: 180 * widthRatio, height: 180 * heightRatio)
                                .foregroundStyle(Color("FSBorderBlue7"))
                            Spacer().frame(height: 8 * heightRatio)
                            Text("Masih kosong, nih")
                                .font(Font.custom("Fredoka", size: 24 * heightRatio).weight(.medium))
                                .multilineTextAlignment(.center)
                                .foregroundStyle(Color("FSBorderBlue7"))
                            Spacer().frame(height: 8 * heightRatio)
                            Text("Masukkan kata kunci yang sesuai untuk\nmenampilkan hasil.")
                                .font(Font.custom("Fredoka", size: 20 * heightRatio))
                                .multilineTextAlignment(.center)
                                .foregroundStyle(Color("FSBorderBlue7"))
                            Spacer()
                        } else if crawlViewModel.isImageUnprocessable {
                            Spacer().frame(height: 100 * heightRatio)
                            ImageNoResultView(widthRatio: widthRatio, heightRatio: heightRatio)
                                .frame(width: 180 * widthRatio, height: 180 * heightRatio)
                                .foregroundStyle(Color("FSBorderBlue7"))
                            Spacer().frame(height: 8 * heightRatio)
                            Text("Ups, tidak ada hasil")
                                .font(Font.custom("Fredoka", size: 24 * heightRatio).weight(.medium))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("FSBorderBlue7"))
                            Spacer().frame(height: 8 * heightRatio)
                            Text("Coba masukkan kata kunci lain.")
                                .font(Font.custom("Fredoka", size: 20 * heightRatio))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("FSBorderBlue7"))
                            Spacer()
                        } else {
                            LazyVGrid(
                                columns: Array(repeating: GridItem(.flexible(), spacing: 10 * heightRatio), count: 3),
                                spacing: 10 * widthRatio
                            ) {
                                ForEach(crawlViewModel.processedImages, id: \.self) { image in
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
                                        .frame(width: 160 * widthRatio, height: 60 * heightRatio)
                                        .foregroundStyle(Color("FSBlue9"))
                                        .cornerRadius(40 * heightRatio)
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
                .padding(.top, 48 * heightRatio)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // TODO: Fix alignment
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
                    .cornerRadius(12 * heightRatio)
                    .shadow(color: Color(.fsBlack).opacity(0.1), radius: 4, y: 4 * heightRatio)
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
