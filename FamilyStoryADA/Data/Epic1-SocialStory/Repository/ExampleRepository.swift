//
//  ExampleRepository.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 24/09/24.
//

import Foundation

internal protocol ExampleRepository {
    func exampleGetData() -> ([ExampleJSONObject], ErrorHandler?)
    func exampleGetDataById(req: ExampleRequest) -> ([ExampleJSONObject], ErrorHandler?)
}

internal final class ImplementedExampleRepository: ExampleRepository {
    private let jsonManager = JsonManager.shared
    
    func exampleGetData() -> ([ExampleJSONObject], ErrorHandler?) {
        let result = jsonManager.loadJSONData(from: "ExampleDataJSON", as: [ExampleJSONObject].self)
        
        switch result {
        case .success(let object):
            return (object, nil)
        case .failure(let error):
            return ([], error)
        }
    }
    
    func exampleGetDataById(req: ExampleRequest) -> ([ExampleJSONObject], ErrorHandler?) {
        let (data, errorHandler) = exampleGetData()
        
        if let error = errorHandler {
            return ([], error)
        }

        let result = data.filter{
            $0.id == req.id
        }
        
        return (result, nil)
    }
}
