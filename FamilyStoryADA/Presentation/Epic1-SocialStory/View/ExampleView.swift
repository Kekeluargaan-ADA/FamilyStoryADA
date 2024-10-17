//
//  ExampleView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 24/09/24.
//

import SwiftUI

struct ExampleView: View {
    @ObservedObject var model: ExampleViewModel = ExampleViewModel(id: UUID(uuidString: "37bff686-7d09-4e53-aa90-fb465da131b5")!)
    var body: some View {
        GeometryReader { geometry in
            Text(model.exampleData.first?.name ?? "Dummy")
        }
    }
}

#Preview {
    ExampleView()
}
