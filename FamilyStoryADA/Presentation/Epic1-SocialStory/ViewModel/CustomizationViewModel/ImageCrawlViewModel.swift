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
    @Published var isImageUnprocessable: Bool = false
    @Published var isBadGateway: Bool = false
    @Published var imageUrls: [String] = []
    @Published var processedImages: [UIImage] = []
    @Published var shouldRemoveBackground: Bool = false
    @Published var selectedImage: UIImage? = nil
    @Published var savedImageFilename: String? = nil
    private var userID: String = ""
    private var backendURL: String = "https://2eb1-202-10-61-41.ngrok-free.app"
    
    private let imageProcessor = CrawlImageHelper()
    
    func crawlImages() {
        clearImageCache()
        userID = UserDefaults.standard.string(forKey: "UserID")!
        // Construct the URL
        guard let url = URL(string: "\(backendURL)/crawl_images/\(userID)/?keyword=\(keyword)&max_num=\(maxNum)") else {
            self.statusMessage = "Invalid URL"
            return
        }
        
        // Update UI state
        isLoading = true
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Start the URL session
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {  // Optional delay
                self.isLoading = false
                
                // Handle request error
                if let error = error {
                    self.statusMessage = "Request failed: \(error.localizedDescription)"
                    return
                }
                
                // Handle HTTP response status codes
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        break // Continue processing on success
                    case 422:
                        self.isImageUnprocessable = true
                        self.statusMessage = "Unprocessable Image Error (HTTP 422)"
                        return
                    default:
                        self.statusMessage = "HTTP Error \(httpResponse.statusCode)"
                        return
                    }
                }
                
                // Check for data availability
                guard let data = data else {
                    self.statusMessage = "No data received"
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(CrawlResponseObject.self, from: data)
                    self.statusMessage = decodedResponse.status
                    self.userID = decodedResponse.userID // Capture hashedUserId
                    self.imageUrls = decodedResponse.imageUrls
                    
                    print("Fetched Image URLs: \(decodedResponse.imageUrls)")
                    
                    // Process each image URL
                    for imageUrl in decodedResponse.imageUrls {
                        if let url = URL(string: imageUrl) {
                            self.downloadAndProcessImage(from: url)
                        }
                    }
                } catch {
                    self.statusMessage = "Failed to parse response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    private func downloadAndProcessImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 422:
                    DispatchQueue.main.async {
                        self.isImageUnprocessable = true
                        self.statusMessage = "Unprocessable Image Error (HTTP 422)"
                    }
                    return
                case 502:
                    DispatchQueue.main.async {
                        self.isBadGateway = true
                        self.statusMessage = "Bad Gateway Error (HTTP 502)"
                    }
                    return
                default:
                    break
                }
            }
            if let data = data, let uiImage = UIImage(data: data) {
                let processedImage = self.shouldRemoveBackground ? self.imageProcessor.removeBackground(from: uiImage) : uiImage
                DispatchQueue.main.async {
                    if let image = processedImage {
                        self.processedImages.append(image)
                    }
                }
            }
        }.resume()
    }
    
    func deleteOtherImages(keeping selectedImage: UIImage) {
        processedImages = [selectedImage]
    }
    
    func deleteImages() {
        let url = URL(string: "\(backendURL)/delete_images/?user_id=\(userID)")!
        
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
