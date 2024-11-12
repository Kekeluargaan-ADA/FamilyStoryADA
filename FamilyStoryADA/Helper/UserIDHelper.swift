//
//  UserIDHelper.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 12/11/24.
//

import Foundation
import CryptoKit

class UserIDHelper{
    func generateUserID() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let timeString = formatter.string(from: currentDate)
        let randomInt = Int.random(in: 1...1000000)
        let randomString = String(randomInt)
        let combinedString = timeString + randomString
        let shuffledString = String(combinedString.shuffled())
        let hashedID = sha256Hash(for: shuffledString)
        return hashedID
    }
    private func sha256Hash(for input: String) -> String {
            let inputData = Data(input.utf8)
            let hashedData = SHA256.hash(data: inputData)
            
            // Convert hashed data to a hex string
            return hashedData.compactMap { String(format: "%02x", $0) }.joined()
        }
}
