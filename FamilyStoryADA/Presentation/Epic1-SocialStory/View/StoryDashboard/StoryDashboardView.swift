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
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer(minLength: geometry.size.width / 2)
                    HStack {
                        SearchBarView()
                        ProfileButtonView(imageName: "")
                    }
                }
                .padding(.horizontal, 20)
                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .foregroundStyle(.tertiary.opacity(0.5))
                    VStack {
                        HStack (spacing: 12) {
                            Spacer()
                            Text("Urutkan")
                                .foregroundStyle(.black)
                            DropdownFilterView()
                        }
                        ScrollView {
                            LazyVGrid(columns: flexibleColumn, spacing: 20) {
                                ForEach (Array(viewModel.stories.enumerated()), id: \.offset) { index, item in
                                    if index == 0 {
                                        NewStoryCardView()
                                    } else {
                                        // TODO: Fix data passing
                                        StoryCardView(
                                            imagePath: "DummyImage",
                                            categoryName: item.templateCategory,
                                            storyName: "Gosok gigi",
                                            lastRead: Date(),
                                            storyLength: 3
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top, 12)
                    .padding(.horizontal, 46)
                }
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    StoryDashboardView()
}
