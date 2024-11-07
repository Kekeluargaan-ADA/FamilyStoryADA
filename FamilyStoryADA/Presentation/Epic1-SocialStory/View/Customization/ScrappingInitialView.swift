
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
                                            viewModel.isGotoScrapImage = false
                                            //presentationMode.wrappedValue.dismiss()
                                        }) {
                                            ButtonCircle(heightRatio: 1.0, buttonImage: "chevron.left", buttonColor: .blue) // Use fixed height for button
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
                                    crawlViewModel.crawlImages()
                                }
                                Button(action: {
                                    crawlViewModel.deleteImages()
                                }, label: {
                                    ButtonCircle(heightRatio: heightRatio, buttonImage: "arrow.clockwise", buttonColor: .blue)
                                })
                            }
                            
                            LazyVGrid(
                                columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3),
                                spacing: 10
                            ) {
                                ForEach(crawlViewModel.processedImages.prefix(6), id: \.self) { image in
                                    ZStack {
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 214 * widthRatio, height: 132 * heightRatio)
                                            .clipped()
                                            .cornerRadius(12)
                                            .shadow(radius: 2, y: 4)
                                            .onTapGesture {
                                                crawlViewModel.selectedImage = image
                                            }
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12 * heightRatio)
                                                    .stroke(crawlViewModel.selectedImage == image ? Color("FSBlue9") : Color.clear, lineWidth: 2 * heightRatio)
                                            )
                                        
                                        if crawlViewModel.selectedImage == image {
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
                            .frame(width: 666 * widthRatio, height: 284 * heightRatio)
                            
                            Spacer()
                            
                            Button(action: {
                                if let selectedImage = crawlViewModel.selectedImage {
//                                    if let filename = crawlViewModel.saveSelectedImageToAppStorage() {
//                                        // Update the page with new image
//                                        if let page = viewModel.selectedPage, page.pagePicture.isEmpty {
//                                            viewModel.selectedPage?.pagePicture.append(
//                                                PictureComponentEntity(
//                                                    componentId: UUID(),
//                                                    componentContent: filename,
//                                                    componentCategory: "AppStoragePicture"
//                                                )
//                                            )
//                                        } else {
//                                            viewModel.selectedPage?.pagePicture.first?.componentContent = filename
//                                            viewModel.selectedPage?.pagePicture.first?.componentCategory = "AppStoragePicture"
//                                        }
//                                        
//                                        // Update the page and close the view
//                                        viewModel.updatePage()
//                                        viewModel.isGotoScrapImage = false
//                                        viewModel.isMediaOverlayOpened = false
//                                        crawlViewModel.deleteImages()
//                                    }
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
