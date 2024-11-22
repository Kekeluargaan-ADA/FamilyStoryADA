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
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    var deletePage: () -> Void
    
    var body: some View {
        HStack {
            HStack (spacing: 12 * widthRatio) {
                if selectedPage != nil {
                    Menu {
                        Button(action: {
                            deletePage()
                        }, label: {
                            Text("Hapus Halaman")
                        })
                    } label: {
                        ButtonCircle(
                            widthRatio: widthRatio,
                            heightRatio: heightRatio,
                            buttonImage: "trash",
                            buttonColor: isDeleteSelected ? .yellow : .blue
                        )
                        .highlight(
                            order: 6,
                            title: "Hapus Halaman",
                            description: "Tekan untuk menghapus halaman ini.",
                            cornerRadius: 40 * heightRatio,
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
//                Button(action: {
//                    UserDefaults.standard.set(true, forKey: "customizationTutorial")
//                    UserDefaults.standard.synchronize()
//                    // Manually re-trigger the modifier's tutorial sequence
//                    NotificationCenter.default.post(name: Notification.Name("RestartTutorial"), object: nil)
//                }, label: {
//                    ButtonCircle(
//                        widthRatio: widthRatio,
//                        heightRatio: heightRatio,
//                        buttonImage: "questionmark",
//                        buttonColor: .blue
//                    )
//                })
            }
            
            Spacer()
            
            HStack(spacing: 12) {
                if selectedPage != nil {
                    NavigationLink(destination: {
                        PlayStoryView(story: story, isMiniQuizPresented: $isMiniQuizPresented)
                    }, label: {
                        ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "play", buttonColor: .blue)
                            .highlight(
                                order: 7,
                                title: "Mulai Cerita",
                                description: "Ceritakan anak anda dengan cerita yang telah dibuat.",
                                cornerRadius: 40 * heightRatio,
                                style: .circular,
                                position: .bottomLeading
                            )
                    })
                    
                    if story.isStoryGameable {
                        Button(action: {
                            isMiniQuizPresented = true
                        }, label: {
                            ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "gamecontroller", buttonColor: .blue)
                                .highlight(
                                    order: 8,
                                    title: "Mainkan Mini-Quiz",
                                    description: "Tes pemahaman anak anda dengan mini-quiz dari cerita yang dibuat.",
                                    cornerRadius: 40 * heightRatio,
                                    style: .circular,
                                    position: .bottomLeading
                                )
                        })
                    }
                }
            }
        }
        
    }
}
