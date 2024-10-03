//
//  CrawlImageProcessorHelper.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian Kurniawan on 03/10/24.
//

import UIKit
import CoreImage
import Vision

class CrawlImageHelper {
    private let ciContext = CIContext()

    func removeBackground(from image: UIImage) -> UIImage? {
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

    private func applyMask(mask: CIImage, to image: CIImage) -> CIImage {
        let filter = CIFilter.blendWithMask()
        filter.inputImage = image
        filter.maskImage = mask
        filter.backgroundImage = CIImage.empty()
        return filter.outputImage!
    }

    private func convertToUIImage(ciImage: CIImage) -> UIImage {
        if let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return UIImage()
    }
}

