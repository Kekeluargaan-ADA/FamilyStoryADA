//
//  CustomizationHeaderView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 01/11/24.
//

import SwiftUI

struct CustomizationHeaderView: View {
    var story: StoryEntity
    var selectedPage: PageEntity?
    @Binding var isMiniQuizPresented: Bool
    @Binding var isDeleteSelected: Bool
    var deletePage: () -> Void
    
    var body: some View {
        HStack {
            if selectedPage != nil {
                Menu {
                    Button(action: {
                        deletePage()
                    }, label: {
                        Text("Hapus Halaman")
                    })
                } label: {
                    ButtonCircle(
                        heightRatio: 1.0,
                        buttonImage: "trash",
                        buttonColor: isDeleteSelected ? .yellow : .blue
                    )
                    .highlight(
                        order: 6,
                        title: "Hapus Halaman",
                        description: "Tekan untuk menghapus halaman ini.",
                        cornerRadius: 40,
                        style: .circular,
                        position: .bottomTrailing
                    )
                }
                .onAppear {
                    isDeleteSelected = false
                }
                .onTapGesture {
                    isDeleteSelected.toggle()
                }
            }
            
            Spacer()
            
            HStack(spacing: 12) {
                NavigationLink(destination: {
                    PlayStoryView(story: story, isMiniQuizPresented: $isMiniQuizPresented)
                }, label: {
                    ButtonCircle(heightRatio: 1.0, buttonImage: "play", buttonColor: .blue)
                        .highlight(
                            order: 7,
                            title: "Mulai Cerita",
                            description: "Ceritakan anak anda dengan cerita yang telah dibuat.",
                            cornerRadius: 40,
                            style: .circular,
                            position: .bottomLeading
                        )
                })
                
                NavigationLink(destination: {
//                    MiniQuizView(story: story)
                    MiniGameView(story: story)
                }, label: {
                    ButtonCircle(heightRatio: 1.0, buttonImage: "gamecontroller", buttonColor: .blue)
                        .highlight(
                            order: 8,
                            title: "Mainkan Mini-Quiz",
                            description: "Tes pemahaman anak anda dengan mini-quiz dari cerita yang dibuat.",
                            cornerRadius: 40,
                            style: .circular,
                            position: .bottomLeading
                        )
                })
            }
        }
    }
}
