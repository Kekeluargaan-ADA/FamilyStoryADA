//
//  ExampleUseCase.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 24/09/24.
//

import Foundation

internal protocol ExampleUseCase {
    func getExampleDataById(req: ExampleRequest) -> ([ExampleJSONObject], ErrorHandler?)
}

internal final class ImplementedExampleUseCase: ExampleUseCase {
    private let exampleRepository: ExampleRepository
    
    init() {
        self.exampleRepository = ImplementedExampleRepository()
    }
    
    func getExampleDataById(req: ExampleRequest) -> ([ExampleJSONObject], ErrorHandler?) {
        return exampleRepository.exampleGetDataById(req: req)
    }
    
    
}
