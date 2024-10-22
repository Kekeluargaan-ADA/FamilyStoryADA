//
//  BriefSquareView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 20/10/24.
//

import SwiftUI

struct BriefSquareView: View {
    let heightRatio: CGFloat
    let widthRatio: CGFloat
    @StateObject private var viewModel = StoryViewModel() // Add the viewModel to handle story logic

    var body: some View {
        Rectangle()
            .foregroundColor(Color("FSWhite"))
            .frame(width: 580, height: 228)
            .cornerRadius(12)
            .shadow(radius: 2 * heightRatio, y: 4 * heightRatio)
            .overlay(
                HStack {
                    Image("DummyImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 280, height: 172 * heightRatio)
                        .cornerRadius(12 * heightRatio)
                    Spacer().frame(width: 20)
                    VStack {
                        Text("Brief singkat terkait ini tentang apa brief singkat terkait ini tentang apa brief singkat terkait ini tentang")
                            .font(
                                Font.custom("Fredoka", size: 16)
                                    .weight(.medium)
                            )
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        Spacer().frame(height: 24 * heightRatio)
                        
                        // Use the button to add new story and then navigate
                        NavigationLink(destination: StoryDashboardView()) {
                            Rectangle()
                                .frame(height: 40 * heightRatio)
                                .foregroundStyle(Color("FSBlue9"))
                                .cornerRadius(40 * heightRatio)
                                .overlay(
                                    Text("Gunakan template")
                                        .font(
                                            Font.custom("Fredoka", size: 20)
                                                .weight(.medium)
                                        )
                                        .foregroundStyle(Color("FSWhite"))
                                )
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            if let id = UUID(uuidString: "819f2cc6-345d-4bfa-b081-2b0d4afc53ab") {
                                viewModel.addNewStory(templateId: id)
                            }
                        })
                    }
                }
                .padding(28 * heightRatio)
            )
    }
}

#Preview {
    BriefSquareView(heightRatio: 1, widthRatio: 1)
}
