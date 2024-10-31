// File.swift
// Gemini
// Created by Vincent Junior Halim on 07/08/24.

import Foundation
import GoogleGenerativeAI

enum APIKey {
    // Fetch the API key from `GenerativeAI-Info.plist`
    static var `default`: String {
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'GenerativeAI-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "Item 0") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'GenerativeAI-Info.plist'.")
        }
        if value.starts(with: "_") {
            fatalError("Follow the instructions at https://ai.google.dev/tutorials/setup to get an API key.")
        }
        return value
    }
}



func getResponse(prompt: String) async throws -> String {
    
    let model = GenerativeModel(name: "gemini-1.5-flash", apiKey:"AIzaSyD0y3-EFPtYL4dM6etCKxJmtl8kxlcjkgA")
    let response = try await model.generateContent(prompt)
    return response.text ?? "No response text available."
}

// qwerty

struct ParaphraseData: Decodable {
    let originalText: String
    let paraphrasedOptions: [ParaphraseOption]

    enum CodingKeys: String, CodingKey {
        case originalText = "original_text"
        case paraphrasedOptions = "paraphrased_options"
    }
}

struct ParaphraseOption: Decodable {
    let option: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dictionary = try container.decode([String: String].self)
        self.option = dictionary.values.first ?? ""
    }
}
