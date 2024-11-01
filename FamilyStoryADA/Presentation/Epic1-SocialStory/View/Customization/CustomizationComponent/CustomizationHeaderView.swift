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
                })
                
                NavigationLink(destination: {
                    MiniQuizView(story: story)
                }, label: {
                    ButtonCircle(heightRatio: 1.0, buttonImage: "gamecontroller", buttonColor: .blue)
                })
            }
        }
    }
}
