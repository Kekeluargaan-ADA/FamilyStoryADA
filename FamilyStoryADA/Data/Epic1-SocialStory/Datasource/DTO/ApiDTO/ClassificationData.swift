//
//  ParaphraseData 2.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 20/11/24.
//


struct ClassificationData: Decodable {
    let originalText: String
    let classification: String

    enum CodingKeys: String, CodingKey {
        case originalText = "original_text"
        case classification = "classification"
    }
}
