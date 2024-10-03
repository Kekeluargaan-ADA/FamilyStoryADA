//
//  CrawlImageResponsesHelper.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 03/10/24.
//

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

struct DeleteResponse: Codable {
    let status: String
    let message: String
}
