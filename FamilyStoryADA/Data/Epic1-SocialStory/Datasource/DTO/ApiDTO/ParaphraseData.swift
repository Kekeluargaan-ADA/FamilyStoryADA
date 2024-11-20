//
//  ParaphraseData.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 20/11/24.
//


struct ParaphraseData: Decodable {
    let originalText: String
    let paraphrasedOptions: [String]

    enum CodingKeys: String, CodingKey {
        case originalText = "original_text"
        case paraphrasedOptions = "paraphrased_texts"
    }
}
