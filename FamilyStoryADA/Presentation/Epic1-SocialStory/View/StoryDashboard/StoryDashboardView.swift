//
//  StoryDashboardView.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 12/10/24.
//

import SwiftUI
import SwiftData

struct StoryDashboardView: View {
    
    @ObservedObject private var viewModel: StoryViewModel = StoryViewModel()
    private let flexibleColumn = [
        GridItem(.fixed(354)),
        GridItem(.fixed(354)),
        GridItem(.fixed(354))
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
                            DropdownFilterView(selectedOption: $viewModel.selectedOption)
                        }
                        ScrollView {
                            LazyVGrid(columns: flexibleColumn, spacing: 26) {
                                ForEach (Array(viewModel.displayedStory.enumerated()), id: \.offset) { index, item in
                                    if index == 0 {
                                        NewStoryCardView()
                                            .padding(.horizontal, 10)
                                    } else {
                                        StoryCardView(
                                            story: item
                                        )
                                        .padding(.horizontal, 10)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top, 12)
                    .padding(.horizontal, 22)
                }
                .ignoresSafeArea()
            }
            .onAppear() {
                viewModel.addNewStory(templateId: UUID(uuidString: "819f2cc6-345d-4bfa-b081-2b0d4afc53ab") ?? UUID())
                viewModel.addNewStory(templateId: UUID(uuidString: "819f2cc6-345d-4bfa-b081-2b0d4afc53ab") ?? UUID())
                viewModel.addNewStory(templateId: UUID(uuidString: "819f2cc6-345d-4bfa-b081-2b0d4afc53ab") ?? UUID())
            }
        }
    }
}

#Preview {
    StoryDashboardView()
}
