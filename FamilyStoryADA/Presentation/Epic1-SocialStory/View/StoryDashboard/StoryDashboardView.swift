//
//  StoryDashboardView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 12/10/24.
//

import SwiftUI

struct StoryDashboardView: View {
    
    private let viewModel = StoryViewModel()
    private let flexibleColumn = [
        
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200))
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("My Story")
                    HStack {
                        // TODO: Search Bar
                        // TODO: Profile Button
                    }
                }
                ZStack {
                    Rectangle()
                    VStack {
                        HStack {
                            Spacer()
                            Text("Urutkan")
                            //TODO: Sort selection
                        }
                        ScrollView {
                            LazyVGrid(columns: flexibleColumn, spacing: 20) {
                                ForEach (Array(viewModel.stories.enumerated()), id: \.offset) { index, item in
                                    if index == 0 {
                                        NewStoryCardView()
                                    } else {
                                        // TODO: Make Story Card
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    StoryDashboardView()
}
