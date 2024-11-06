//
//  ResponseObject.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 03/10/24.
//

struct CrawlResponseObject: Codable {
    let status: String
    let message: String
    let timeTaken: String
    let imageUrls: [String]
    let userID: String

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case timeTaken = "time_taken"
        case imageUrls = "image_urls"
        case userID = "user_id"
    }
}

struct DeleteResponseObject: Codable {
    let status: String
    let message: String
}
