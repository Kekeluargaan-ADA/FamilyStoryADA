//
//  SampleImageCrawlView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian Kurniawan on 01/10/24.
//

import SwiftUI

struct SampleImageCrawlView: View {
    @StateObject private var viewModel = SampleImageCrawlViewModel()

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter keyword", text: $viewModel.keyword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Max number of images", text: $viewModel.maxNum)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

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

            Text(viewModel.statusMessage)
                .padding()

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(viewModel.processedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
                }
            }
        }
        .padding()
    }
}

