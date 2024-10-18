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
                                        ButtonCircle(heightRatio: heightRatio, buttonImage: "chevron.left", onTap: {})
                                        Spacer()
                                    }
                                    Text("Cari Foto")
                                        .font(.system(size: 32 * heightRatio))
                                        .fontWeight(.bold)
                                }
                            }
                            HStack {
                                // Pass the crawlImages call as the onCommit closure
                                SearchBarView(searchText: $viewModel.keyword) {
                                    viewModel.crawlImages()
                                }
                                ButtonCircle(heightRatio: heightRatio, buttonImage: "arrow.clockwise", onTap: {
                                    viewModel.clearSelection()
                                })
                            }
                            
                            Button(action: {
                                viewModel.deleteImages()
                            }) {
                                Text("Delete All Images")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(8)
                            }
                            .disabled(viewModel.isLoading)

                            LazyVGrid(
                                columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3),
                                spacing: 10
                            ) {
                                ForEach(viewModel.processedImages.prefix(6), id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 214 * widthRatio, height: 132 * heightRatio)
                                        .clipped()
                                        .cornerRadius(12)
                                        .shadow(radius: 2, y: 4)
                                }
                            }
                            .frame(width: 666 * widthRatio, height: 284 * heightRatio)
                            Spacer()
                        }
                        .padding(24 * heightRatio)
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}