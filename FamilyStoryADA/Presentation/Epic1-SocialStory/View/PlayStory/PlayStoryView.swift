//
//  PlayStoryView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 10/10/24.
//

import SwiftUI
import AVKit

struct PlayStoryView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var playStoryViewModel: PlayStoryViewModel
    
    init(story: StoryEntity) {
        _playStoryViewModel = StateObject(wrappedValue: PlayStoryViewModel(story: story))
    }
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
                let heightRatio = ratios.heightRatio
                let widthRatio = ratios.widthRatio
                
                VStack {
                    Spacer()
                    PlayStoryNavigationView(heightRatio: heightRatio, title: playStoryViewModel.story.storyName, buttonColor: .yellow, onTapHomeButton: {
                        dismiss()
                    }, onTapAudioButton: {
                        //TODO: Read aloud voice synthensizer
                    })
                    .padding(.top, 47 * heightRatio)
                    .padding(.horizontal, 46 * widthRatio)
                    Spacer().frame(height: 21 * heightRatio)
                    ZStack {
                        //Content
                        ZStack {
                            
                            if let image = playStoryViewModel.selectedPage?.pagePicture.first {
                                if image.componentCategory == "AssetPicture" {
                                    Image(image.componentContent)
                                        .frame(width: 876 * widthRatio, height: 540 * heightRatio)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                } else if let imageAppStorage = playStoryViewModel.loadImageFromDiskWith(fileName: image.componentContent) {
                                    Image(uiImage: imageAppStorage)
                                        .frame(width: 876 * widthRatio, height: 540 * heightRatio)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                }else {
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundStyle(Color("FSWhite"))
                                        .frame(width: 876 * widthRatio, height: 540 * heightRatio)
                                }
                            } else if let video = playStoryViewModel.selectedPage?.pageVideo.first, let url = Bundle.main.url(forResource: video.componentContent, withExtension: "mp4") {
                                
                                //Video
                                let videoPlayer = AVPlayer(url: url)
                                
                                VideoPlayer(player: videoPlayer)
                                    .frame(width: 876 * widthRatio, height: 540 * heightRatio)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .onAppear() {
                                        
                                        videoPlayer.play()
                                        
                                    }
                                    .onDisappear() {
                                        videoPlayer.pause()
                                    }
                            } else {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundStyle(Color("FSWhite"))
                                    .frame(width: 876 * widthRatio, height: 540 * heightRatio)
                            }
                        }
                        .frame(width: 876 * widthRatio, height: 540 * heightRatio)
                        
                        //Button
                        HStack {
                            if playStoryViewModel.currentPageNumber > 0 {
                                Button(action: {
                                    playStoryViewModel.continueToPreviousPage()
                                }, label: {
                                    ButtonCircle(heightRatio: 1.0, buttonImage: "chevron.left", buttonColor: .yellow)
                                })
                                .padding(.leading, -32 * heightRatio)
                            }
                            
                            Spacer()
                            if playStoryViewModel.currentPageNumber < playStoryViewModel.story.pages.count - 1 {
                                Button(action: {
                                    playStoryViewModel.continueToNextPage()
                                }, label: {
                                    ButtonCircle(heightRatio: 1.0, buttonImage: "chevron.right", buttonColor: .yellow)
                                })
                                
                                .padding(.trailing, -32 * heightRatio)
                            } else {
                                NavigationLink(destination: {
                                    PlayStoryResultView()
                                        .environmentObject(playStoryViewModel)
                                }, label: {
                                    ButtonCircle(heightRatio: 1.0, buttonImage: "chevron.right", buttonColor: .yellow)
                                })
                            }
                        }
                        .frame(width: 1055 * widthRatio, height: 519 * heightRatio)
                    }
                    
                    if playStoryViewModel.selectedPage?.pageType == "Opening" || playStoryViewModel.selectedPage?.pageType == "Closing" {
                        Spacer().frame(height: 19 * heightRatio)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 80)
                                .foregroundStyle(Color("FSWhite"))
                                .frame(width: 1100 * widthRatio, height: 160 * heightRatio)
                                .shadow(radius: 4, y: 4)
                            Text(playStoryViewModel.selectedPage?.pageText.first?.componentContent ?? "")
                                .frame(width: 700 * widthRatio, height: 160 * heightRatio)
                                .lineLimit(nil)
                                .multilineTextAlignment(.center)
                                .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color("FSBlack"))
                        }
                        Spacer().frame(height: 55 * heightRatio)
                        
                    } else {
                        Spacer().frame(height: 24 * heightRatio)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 40)
                                .foregroundStyle(Color("FSWhite"))
                                .frame(width: 1194 * widthRatio, height: 200 * heightRatio)
                                .shadow(radius: 10, y: -4)
                            Text(playStoryViewModel.selectedPage?.pageText.first?.componentContent ?? "")
                                .frame(width: 700 * widthRatio, height: 160 * heightRatio)
                                .lineLimit(nil)
                                .multilineTextAlignment(.center)
                                .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color("FSBlack"))
                        }
                    }
                        
                    
                }
                // TODO: Not working
                NavigationLink(isActive: $playStoryViewModel.isStoryGoToMiniQuiz, destination: {
                    MiniQuizView(story: playStoryViewModel.story)
                }, label: {
                    
                })
            }
            .background(Color("FSYellow1"))
        }
        .navigationBarBackButtonHidden()
        .navigationViewStyle(.stack)
        .environmentObject(playStoryViewModel)
        .onChange(of: playStoryViewModel.isStoryCompleted) {
            if playStoryViewModel.isStoryCompleted {
                dismiss()
            }
        }
    }
}


//#Preview {
//    PlayStoryView()
//}
