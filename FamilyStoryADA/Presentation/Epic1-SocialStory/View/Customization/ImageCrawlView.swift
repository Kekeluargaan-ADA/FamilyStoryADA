//
//  ImageCrawlView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 17/10/24.
//

import SwiftUI

struct ImageCrawlView: View {
    @StateObject private var viewModel = ImageCrawlViewModel()
    @State private var isImageSelected: Bool = false // Track if an image has been selected
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Keyword input
                    TextField("Enter keyword", text: $viewModel.keyword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    // Max number input
                    TextField("Max number of images", text: $viewModel.maxNum)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    // Toggle for background removal
                    Toggle("Remove Background", isOn: $viewModel.shouldRemoveBackground)
                        .padding()
                    
                    // Crawl images button
                    Button(action: {
                        viewModel.crawlImages()
                    }) {
                        Text("Crawl Images")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .disabled(viewModel.isLoading)
                    
                    // Delete all images button
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
                    
                    // Status message
                    Text(viewModel.statusMessage)
                        .padding()
                    
                    // Image display (TabView for processed images)
                    if !viewModel.processedImages.isEmpty {
                        TabView {
                            ForEach(viewModel.processedImages, id: \.self) { image in
                                NavigationLink(
                                    destination: SelectedImageView(image: image),
                                    label: {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .padding()
                                            .border(viewModel.selectedImage == image ? Color.green : Color.clear, width: 4) // Green border for selected image
                                            .onTapGesture {
                                                viewModel.selectedImage = image // Set selected image
                                                isImageSelected = true // Image selected
                                            }
                                    }
                                )
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .frame(height: 300)
                    } else {
                        Text("No images available.")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .navigationTitle("Image Crawler")
            }
        }
        .navigationViewStyle(.stack)
    }
}
