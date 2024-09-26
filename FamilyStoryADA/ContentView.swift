//
//  ContentView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 23/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
//                Color.red
//                    .frame(
//                        width: geometry.size.width,
//                        height: geometry.size.height,
//                        alignment: .leading
//                )
//                    .aspectRatio(contentMode: ContentMode.fill)
                ExampleView()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
