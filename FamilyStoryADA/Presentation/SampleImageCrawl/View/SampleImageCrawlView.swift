import SwiftUI
import Vision
import CoreImage.CIFilterBuiltins

struct SampleImageCrawlView: View {
    @State private var keyword: String = ""
    @State private var maxNum: String = "3"
    @State private var statusMessage: String = ""
    @State private var isLoading: Bool = false
    @State private var imageUrls: [String] = []  // To store image URLs
    @State private var processedImages: [UIImage] = []  // Store processed images with removed background
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter keyword", text: $keyword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Max number of images", text: $maxNum)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                crawlImages()
            }) {
                Text("Crawl Images")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .disabled(isLoading)

            Button(action: {
                deleteImages()
            }) {
                Text("Delete All Images")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .disabled(isLoading)

            Text(statusMessage)
                .padding()

            // Display images asynchronously
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(processedImages, id: \.self) { image in
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

    // Function to trigger image crawling
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
                isLoading = false
                if let error = error {
                    statusMessage = "Request failed: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    statusMessage = "No data received"
                    return
                }

                if let decodedResponse = try? JSONDecoder().decode(CrawlResponse.self, from: data) {
                    statusMessage = "\(decodedResponse.message) (Time taken: \(decodedResponse.timeTaken))"
                    imageUrls = decodedResponse.imageUrls  // Set the image URLs
                    
                    // Process each image URL to remove background
                    for imageUrl in imageUrls {
                        if let url = URL(string: imageUrl) {
                            downloadAndProcessImage(from: url)
                        }
                    }
                } else {
                    statusMessage = "Failed to parse response"
                }
            }
        }.resume()
    }

    // Function to download an image and remove its background
    func downloadAndProcessImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let uiImage = UIImage(data: data) {
                if let processedImage = removeBackground(from: uiImage) {
                    DispatchQueue.main.async {
                        processedImages.append(processedImage)
                    }
                }
            }
        }.resume()
    }

    // Background removal functionality
    private func removeBackground(from image: UIImage) -> UIImage? {
        guard let inputImage = CIImage(image: image) else {
            print("Failed to create CIImage")
            return nil
        }

        let request = VNGenerateForegroundInstanceMaskRequest()
        let handler = VNImageRequestHandler(ciImage: inputImage)

        do {
            try handler.perform([request])
            if let result = request.results?.first {
                let mask = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: handler)
                let maskImage = CIImage(cvPixelBuffer: mask)
                let outputImage = applyMask(mask: maskImage, to: inputImage)
                return convertToUIImage(ciImage: outputImage)
            }
        } catch {
            print(error)
        }
        return nil
    }

    // Helper functions for background removal
    func applyMask(mask: CIImage, to image: CIImage) -> CIImage {
        let filter = CIFilter.blendWithMask()
        filter.inputImage = image
        filter.maskImage = mask
        filter.backgroundImage = CIImage.empty()
        return filter.outputImage!
    }

    func convertToUIImage(ciImage: CIImage) -> UIImage {
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return UIImage()
    }

    // Function to delete all images
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
                isLoading = false
                if let error = error {
                    statusMessage = "Request failed: \(error.localizedDescription)"
                    return
                }

                if let decodedResponse = try? JSONDecoder().decode(DeleteResponse.self, from: data!) {
                    statusMessage = decodedResponse.message
                    processedImages.removeAll()  // Clear the processed images
                    clearImageCache()  // Clear cache after deleting images
                } else {
                    statusMessage = "Failed to parse response"
                }
            }
        }.resume()
    }

    // Function to clear URL cache for old images
    func clearImageCache() {
        let cache = URLCache.shared
        cache.removeAllCachedResponses()
        print("Image cache cleared")
    }
}

// Define a struct for parsing the crawl response
struct CrawlResponse: Codable {
    let status: String
    let message: String
    let timeTaken: String
    let imageUrls: [String]

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case timeTaken = "time_taken"
        case imageUrls = "image_urls"
    }
}

// Define a struct for parsing the delete response
struct DeleteResponse: Codable {
    let status: String
    let message: String
}
