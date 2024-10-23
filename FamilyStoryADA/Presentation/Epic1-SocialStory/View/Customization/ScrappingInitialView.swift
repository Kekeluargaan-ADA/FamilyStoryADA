//
//  ScrappingInitialView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 18/10/24.
//

import SwiftUI

struct ScrappingInitialView: View {
    @State private var isModalPresented = false
    @StateObject private var viewModel = ImageCrawlViewModel()
    @State private var isImageSelected: Bool = false
    
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
                                        ButtonCircle(heightRatio: heightRatio, buttonImage: "chevron.left", buttonColor: .blue)
                                        Spacer()
                                    }
                                    Text("Cari Foto")
                                        .font(.system(size: 32 * heightRatio))
                                        .fontWeight(.bold)
                                }
                            }
                            HStack {
                                SearchBarView(searchText: $viewModel.keyword) {
                                    viewModel.crawlImages()
                                }
                                Button(action: {
                                    viewModel.deleteImages()
                                }, label: {
                                    ButtonCircle(heightRatio: heightRatio, buttonImage: "arrow.clockwise", buttonColor: .blue)
                                })
                            }
                            
                            LazyVGrid(
                                columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3),
                                spacing: 10
                            ) {
                                ForEach(viewModel.processedImages.prefix(6), id: \.self) { image in
                                    ZStack {
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 214 * widthRatio, height: 132 * heightRatio)
                                            .clipped()
                                            .cornerRadius(12)
                                            .shadow(radius: 2, y: 4)
                                            .onTapGesture {
                                                viewModel.selectedImage = image
                                            }
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12 * heightRatio)
                                                    .stroke(viewModel.selectedImage == image ? Color("FSBlue9") : Color.clear, lineWidth: 2 * heightRatio)
                                            )
                                        
                                        if viewModel.selectedImage == image {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(Color("FSWhite"))
                                                .font(.system(size: 20 * heightRatio))
                                                .bold()
                                                .position(x: 214 * widthRatio - 17 * widthRatio, y: 17 * heightRatio)
                                        }
                                    }
                                }
                            }
                            .frame(width: 666 * widthRatio, height: 284 * heightRatio)
                            
                            Spacer()
                            
                            Button(action: {
                                if let selectedImage = viewModel.selectedImage {
                                    let uuid = viewModel.saveSelectedImageToAppStorage() // Use the ViewModel's method
                                    selectedImageUUID = uuid // Save the UUID in AppStorage
                                    isModalPresented = true
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
                            .sheet(isPresented: $isModalPresented) {
                                AnotherView()
                            }
                        }
                        .padding(24 * heightRatio)
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
