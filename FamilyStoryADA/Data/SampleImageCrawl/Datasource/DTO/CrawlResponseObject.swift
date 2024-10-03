//
//  CrawlResponseObject.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian Kurniawan on 03/10/24.
//

struct CrawlResponseObject: Codable {
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
