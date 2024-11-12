//
//  ResponseObject.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 03/10/24.
//

struct CrawlResponseObject: Codable {
    let status: String
    let userID: String
    let imageUrls: [String]
    

    enum CodingKeys: String, CodingKey {
        case status
        case userID = "user_id"
        case imageUrls = "images_urls"
        
    }
}

struct DeleteResponseObject: Codable {
    let status: String
    let message: String
}
