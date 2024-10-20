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
    @StateObject var viewModel: PlayStoryViewModel
    
    init(story: StoryEntity) {
        _viewModel = StateObject(wrappedValue: PlayStoryViewModel(story: story))
    }
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
                let heightRatio = ratios.heightRatio
                let widthRatio = ratios.widthRatio
                
                VStack {
                    Spacer()
                    PlayStoryNavigationView(heightRatio: heightRatio, title: viewModel.story.storyName, buttonColor: .yellow, onTapHomeButton: {
                        dismiss()
                    }, onTapAudioButton: {
                        //TODO: Read aloud voice synthensizer
                    })
                    Spacer().frame(height: 21 * heightRatio)
                    ZStack {
                        //Content
                        ZStack {
                            
                            if let image = viewModel.selectedPage?.pagePicture.first {
                                if image.componentCategory == "AssetPicture" {
                                    Image(image.componentContent)
                                        .frame(width: 876 * widthRatio, height: 540 * heightRatio)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                } else {
                                    //TODO: Add app storage image
                                }
                            } else if let video = viewModel.selectedPage?.pageVideo.first, let url = Bundle.main.url(forResource: video.componentContent, withExtension: "mp4") {
                                
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
                            if viewModel.currentPageNumber > 0 {
                                Button(action: {
                                    viewModel.continueToPreviousPage()
                                }, label: {
                                    ButtonCircle(heightRatio: 1.0, buttonImage: "chevron.left", buttonColor: .yellow)
                                })
                                .padding(.leading, -32 * heightRatio)
                            }
                            
                            Spacer()
                            if viewModel.currentPageNumber < viewModel.story.pages.count - 1 {
                                Button(action: {
                                    viewModel.continueToNextPage()
                                }, label: {
                                    ButtonCircle(heightRatio: 1.0, buttonImage: "chevron.right", buttonColor: .yellow)
                                })
                                
                                .padding(.trailing, -32 * heightRatio)
                            } else {
                                NavigationLink(destination: {
                                    // TODO: Goto PageClosing
                                    PlayStoryClosingView()
                                }, label: {
                                    ButtonCircle(heightRatio: 1.0, buttonImage: "chevron.right", buttonColor: .yellow)
                                })
                            }
                        }
                        .frame(width: 1055 * widthRatio, height: 519 * heightRatio)
                    }
                    Spacer().frame(height: 24 * heightRatio)
                    
                    
                    Text(viewModel.selectedPage?.pageText.first?.componentContent ?? "")
                        .frame(width: 700 * widthRatio, height: 160 * heightRatio)
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                        .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("FSBlack"))
                        
                    Spacer().frame(height: 55 * heightRatio)
                }
                .padding(47 * heightRatio)
            }
            .background(Color("FSYellow1"))
        }
        .navigationBarBackButtonHidden()
        .navigationViewStyle(.stack)
    }
}


//#Preview {
//    PlayStoryView()
//}
