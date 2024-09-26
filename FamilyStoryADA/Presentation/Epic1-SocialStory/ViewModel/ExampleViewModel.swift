//
//  ExampleViewModel.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 24/09/24.
//

import Foundation

class ExampleViewModel: ObservableObject {
    
    @Published var exampleData: [ExampleJSONObject] = []
    
    let exampleUseCase: ExampleUseCase
    
    init(id: UUID?) {
        self.exampleUseCase = ImplementedExampleUseCase()
        let (data, errorCode) = exampleUseCase.getExampleDataById(req: .init(id: id!))
        exampleData = data
    }
}
