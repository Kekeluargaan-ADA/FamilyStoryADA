//
//  SampleImageCrawlViewModel.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian Kurniawan on 17/10/24.
//

import SwiftUI
import Vision
import CoreImage.CIFilterBuiltins

class ImageCrawlViewModel: ObservableObject {
    @Published var keyword: String = ""
    @Published var maxNum: String = "6"
    @Published var statusMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var imageUrls: [String] = []
    @Published var processedImages: [UIImage] = []
    @Published var shouldRemoveBackground: Bool = false
    @Published var selectedImage: UIImage? = nil
    @Published var savedImageFilename: String? = nil  // Added new property

    private let imageProcessor = CrawlImageHelper()

    func crawlImages() {
        clearImageCache()

        guard let url = URL(string: "https://working-epic-dodo.ngrok-free.app/crawl_images/?keyword=\(keyword)&max_num=\(maxNum)") else {
            statusMessage = "Invalid URL"
            return
        }

        isLoading = true
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.isLoading = false
                if let error = error {
                    self.statusMessage = "Request failed: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self.statusMessage = "No data received"
                    return
                }

                if let decodedResponse = try? JSONDecoder().decode(CrawlResponseObject.self, from: data) {
                    self.statusMessage = "\(decodedResponse.message) (Time taken: \(decodedResponse.timeTaken))"
                    self.imageUrls = []  // Clear URLs before adding new ones

                    for imageUrl in decodedResponse.imageUrls {
                        if let url = URL(string: imageUrl) {
                            self.downloadAndProcessImage(from: url, imageUrl: imageUrl)
                        }
                    }
                } else {
                    self.statusMessage = "Failed to parse response"
                }
            }
        }.resume()
    }

    private func downloadAndProcessImage(from url: URL, imageUrl: String) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let uiImage = UIImage(data: data) {
                let processedImage = self.shouldRemoveBackground ? self.imageProcessor.removeBackground(from: uiImage) : uiImage
                DispatchQueue.main.async {
                    if let image = processedImage {
                        self.processedImages.append(image)
                        self.imageUrls.append(imageUrl)  // Add corresponding URL
                    }
                }
            }
        }.resume()
    }

    func deleteOtherImages(keeping selectedImage: UIImage) {
        processedImages = [selectedImage]
    }

    func deleteImages() {
        guard let url = URL(string: "https://working-epic-dodo.ngrok-free.app/delete_images/") else {
            statusMessage = "Invalid URL"
            return
        }

        isLoading = true
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.statusMessage = "Request failed: \(error.localizedDescription)"
                    return
                }

                if let decodedResponse = try? JSONDecoder().decode(DeleteResponseObject.self, from: data!) {
                    self.statusMessage = decodedResponse.message
                    self.processedImages.removeAll()
                    self.clearImageCache()
                } else {
                    self.statusMessage = "Failed to parse response"
                }
            }
        }.resume()
    }

    private func clearImageCache() {
        let cache = URLCache.shared
        cache.removeAllCachedResponses()
        print("Image cache cleared")
    }

    func clearSelection() {
        selectedImage = nil
        savedImageFilename = nil
    }

    func saveSelectedImageToAppStorage() -> String? {
        guard let image = selectedImage, let data = image.jpegData(compressionQuality: 1.0) else {
            print("Error: No image selected or could not create JPEG data.")
            return nil
        }

        let filename = UUID().uuidString + ".jpg"
        let fileManager = FileManager.default

        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent(filename)

            do {
                try data.write(to: fileURL)
                self.savedImageFilename = filename
                print("Selected image saved to app storage: \(fileURL.path)")
                return filename
            } catch {
                print("Error saving image to app storage: \(error)")
                return nil
            }
        }
        return nil
    }
}
