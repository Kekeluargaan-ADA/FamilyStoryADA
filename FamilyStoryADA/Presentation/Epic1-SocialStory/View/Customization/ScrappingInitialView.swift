
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
    @State private var isImageSelected: Bool = false
    @EnvironmentObject var viewModel: PageCustomizationViewModel
    @EnvironmentObject var cameraViewModel: CameraViewModel
    
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
                            HStack {
                                ZStack {
                                    HStack {
                                        Button(action: {
                                            crawlViewModel.deleteImages()
                                            viewModel.isGotoScrapImage = false
                                        }) {
                                            ButtonCircle(heightRatio: 1.0, buttonImage: "chevron.left", buttonColor: .blue)
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
                                SearchBarView(searchText: $crawlViewModel.keyword) {
                                    crawlViewModel.deleteImages()
                                    crawlViewModel.crawlImages()
                                }
                                Button(action: {
                                    crawlViewModel.deleteImages()
                                }, label: {
                                    ButtonCircle(heightRatio: heightRatio, buttonImage: "arrow.clockwise", buttonColor: .blue)
                                })
                            }
                            .zIndex(1)
                            
                            LazyVGrid(
                                columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3),
                                spacing: 10
                            ) {
                                ForEach(Array(zip(crawlViewModel.processedImages.prefix(6), crawlViewModel.imageUrls.prefix(6))), id: \.1) { image, url in
                                    VStack {
                                        ZStack {
                                            Button(action: {
                                                crawlViewModel.selectedImage = image
                                            }) {
                                                AsyncImage(url: URL(string: url)) { image in
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 214 * widthRatio, height: 132 * heightRatio)
                                                        .clipped()
                                                        .cornerRadius(12)
                                                        .shadow(radius: 2, y: 4)
                                                } placeholder: {
                                                    Color.gray
                                                }
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                            .contentShape(RoundedRectangle(cornerRadius: 12 * heightRatio))

                                            RoundedRectangle(cornerRadius: 12 * heightRatio)
                                                .stroke(crawlViewModel.selectedImage == image ? Color("FSBlue9") : Color.clear, lineWidth: 2 * heightRatio)
                                                .frame(width: 214 * widthRatio, height: 132 * heightRatio)

                                            if crawlViewModel.selectedImage == image {
                                                ZStack {
                                                    // Background circle
                                                    Circle()
                                                        .fill(Color("FSBlue9"))            // Background color
                                                        .frame(width: 30 * heightRatio,    // Adjust size as needed
                                                               height: 30 * heightRatio)

                                                    // SF Symbol with overlay color and positioning
                                                    Image(systemName: "checkmark.circle.fill")
                                                        .foregroundStyle(Color("FSBlue9"), Color("FSWhite"))
                                                        .font(.system(size: 20 * heightRatio))
                                                        .bold()
                                                }
                                                .position(x: 214 * widthRatio - 17 * widthRatio, y: 17 * heightRatio)

                                            }
                                        }
//                                        Text(url)
//                                            .font(.caption)
//                                            .foregroundColor(.gray)
//                                            .frame(width: 214 * widthRatio, alignment: .leading)
//                                            .lineLimit(1)
//                                            .truncationMode(.tail)
                                    }
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
                        .padding(24 * heightRatio)
                    )
                if crawlViewModel.isLoading {
                    VStack {
                        Spacer()
                        Rectangle().foregroundStyle(.red)
                        Spacer()
                    }
                    .frame(width: 728 * widthRatio, height: 743 * heightRatio)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
