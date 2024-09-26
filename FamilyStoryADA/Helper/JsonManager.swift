//
//  JsonManager.swift
//  StorybookInteractive
//
//  Created by Doni Pebruwantoro on 14/08/24.
//

import Foundation
import Combine

public class JsonManager {
    static let shared = JsonManager()
    
    private init() {}
    
    func loadJSONData<T: Codable>(from fileName: String, as type: T.Type) -> Result<T, ErrorHandler> {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return .failure(.fileNotFound)
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            
            return .success(decodedData)
        } catch let error as DecodingError {
            return .failure(.decodedFailed(error))
        } catch {
            return .failure(.dataCorrupted)
        }
    }
}
