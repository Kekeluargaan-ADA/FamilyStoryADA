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
    @Binding var isMiniQuizPresented: Bool
    private let textToSpeechHelper = TextToSpeechHelper()
    @State var playStoryIsActive = false
    private let soundEffectHelper = SoundEffectHelper()
    init(story: StoryEntity, isMiniQuizPresented: Binding<Bool>) {
        _playStoryViewModel = StateObject(wrappedValue: PlayStoryViewModel(story: story))
        _isMiniQuizPresented = isMiniQuizPresented
    }
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                let ratios = ScreenSizeHelper.calculateRatios(geometry: geometry)
                let heightRatio = ratios.heightRatio
                let widthRatio = ratios.widthRatio
                
                
                ZStack {
                    //background for opening and closing
                    if playStoryViewModel.selectedPage?.pageType == "Opening" || playStoryViewModel.selectedPage?.pageType == "Closing" {
                        Image("checkered-background")
                            .resizable()
                            .ignoresSafeArea()
                    }
                    
                    //Content
                    ZStack {
                        if let image = playStoryViewModel.selectedPage?.pagePicture.first {
                            if playStoryViewModel.selectedPage?.pageType == "Opening" || playStoryViewModel.selectedPage?.pageType == "Closing" {
                                ZStack {
                                    Image("picture-frame")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 395 * widthRatio, height: 480 * heightRatio)
                                    if let imageAppStorage = playStoryViewModel.loadImageFromDiskWith(fileName: image.componentContent) {
                                        Image(uiImage: imageAppStorage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 309 * widthRatio, height: 412 * heightRatio)
                                            .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12 * heightRatio)
                                                    .stroke(Color(.fsBlueBorder2), lineWidth: 3)
                                            )
                                    } else {
                                        Image(image.componentContent)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 309 * widthRatio, height: 412 * heightRatio)
                                            .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12 * heightRatio)
                                                    .stroke(Color(.fsBlueBorder2), lineWidth: 3)
                                            )
                                    }
                                }
                                .offset(y: -32 * heightRatio)
                            } else {
                                if image.componentCategory == "AssetPicture" {
                                    Image(image.componentContent)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 876 * widthRatio, height: 540 * heightRatio)
                                        .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                                        .offset(y: -48 * heightRatio)
                                } else if let imageAppStorage = playStoryViewModel.loadImageFromDiskWith(fileName: image.componentContent) {
                                    Image(uiImage: imageAppStorage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 876 * widthRatio, height: 540 * heightRatio)
                                        .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                                        .offset(y: -48 * heightRatio)
                                } else {
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundStyle(Color("FSWhite"))
                                        .frame(width: 876 * widthRatio, height: 540 * heightRatio)
                                        .offset(y: -48 * heightRatio)
                                }
                            }
                        } else if let video = playStoryViewModel.selectedPage?.pageVideo.first, let url = Bundle.main.url(forResource: video.componentContent, withExtension: "mp4") {
                            
                            ZStack {
                                CustomVideoPlayerView(player: playStoryViewModel.videoPlayer, isReadyToPlay: $playStoryViewModel.isVideoReadyToPlay)
                                    .frame(width: 876 * widthRatio, height: 540 * heightRatio)
                                    .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                                    .onAppear() {
                                        playStoryViewModel.videoPlayer = AVPlayer(url: url)
                                        playStoryViewModel.videoPlayer.play()
                                    }
                                    .onDisappear() {
                                        playStoryViewModel.videoPlayer.pause()
                                    }
                                    .onChange(of: url) {
                                        playStoryViewModel.videoPlayer = AVPlayer(url: url)
                                        playStoryViewModel.videoPlayer.play()
                                    }
                                    .onTapGesture() {
                                        playStoryViewModel.videoPlayer.seek(to: .zero)
                                        playStoryViewModel.videoPlayer.play()
                                        Task {
                                            //MARK: turn this on when we need play sound effect
                                            //                                            await soundEffectHelper.playSound(fileName: )
                                        }
                                    }
                                    .offset(y: -48 * heightRatio)
                                if !playStoryViewModel.isVideoReadyToPlay {
                                    Image(video.componentContent)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 876 * widthRatio, height: 540 * heightRatio)
                                        .clipShape(RoundedRectangle(cornerRadius: 12 * heightRatio))
                                        .offset(y: -48 * heightRatio)
                                }
                            }
                            
                            
                        } else {
                            RoundedRectangle(cornerRadius: 12 * heightRatio)
                                .foregroundStyle(Color("FSWhite"))
                                .frame(width: 876 * widthRatio, height: 540 * heightRatio)
                                .offset(y: -48 * heightRatio)
                        }
                    }
                    .frame(width: 876 * widthRatio, height: 540 * heightRatio)
                    
                    //background
                    Image("background-play-story")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .onTapGesture {
                            playStoryViewModel.videoPlayer.seek(to: .zero)
                            playStoryViewModel.videoPlayer.play()
                            Task {
                                //MARK: turn this on when we need play sound effect
                                //                                            await soundEffectHelper.playSound(fileName: )
                            }
                        }
                    
                    VStack {
                        PlayStoryNavigationView(widthRatio: widthRatio, heightRatio: heightRatio, title: playStoryViewModel.story.storyName, buttonColor: .yellow, onTapHomeButton: {
                            playStoryViewModel.isStoryCompleted = true
                        }, onTapAudioButton: {
                            if let text = playStoryViewModel.selectedPage?.pageText.first?.componentContent {
                                textToSpeechHelper.speakIndonesian(text)
                            }
                        }, showAudioButton: true,
                                                titleOverlayReversed: false
                        )
                        .padding(.top, 38 * heightRatio)
                        .padding(.horizontal, 46 * widthRatio)
                        Spacer()
                    }
                    
                    VStack {
                        //Button
                        HStack {
                            if playStoryViewModel.currentPageNumber > 0 {
                                Button(action: {
                                    playStoryViewModel.isVideoReadyToPlay = false
                                    textToSpeechHelper.stopSpeaking()
                                    playStoryViewModel.continueToPreviousPage()
                                    
                                }, label: {
                                    ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "chevron.left", buttonColor: .yellow)
                                })
                                .padding(.leading, -32 * heightRatio)
                            }
                            
                            Spacer()
                            if playStoryViewModel.currentPageNumber < playStoryViewModel.story.pages.count - 1 {
                                Button(action: {
                                    playStoryViewModel.isVideoReadyToPlay = false
                                    textToSpeechHelper.stopSpeaking()
                                    playStoryViewModel.continueToNextPage()
                                    
                                }, label: {
                                    ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "chevron.right", buttonColor: .yellow)
                                })
                                
                                .padding(.trailing, -32 * heightRatio)
                            } else {
                                
                                Button(action: {
                                    textToSpeechHelper.stopSpeaking()
                                    playStoryIsActive = true
                                    playStoryViewModel.isVideoReadyToPlay = false
                                    
                                }, label: {
                                    ButtonCircle(widthRatio: widthRatio, heightRatio: heightRatio, buttonImage: "chevron.right", buttonColor: .yellow)
                                        .padding(.trailing, -32 * heightRatio)
                                })
                                
                                NavigationLink(isActive: $playStoryIsActive,destination: {
                                    PlayStoryResultView(isMiniQuizPresented: $isMiniQuizPresented)
                                        .environmentObject(playStoryViewModel)
                                }, label: {})
                            }
                        }
                        .padding(.horizontal, 100 * widthRatio)
                        .padding(.bottom, 28 * heightRatio)
                    }
                    .offset(y: 30 * heightRatio)
                    
                    VStack {
                        Spacer()
                        //Text
                        if playStoryViewModel.selectedPage?.pageType == "Opening" || playStoryViewModel.selectedPage?.pageType == "Closing" {
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 80 * heightRatio)
                                    .foregroundStyle(Color("FSWhite"))
                                    .frame(width: 1100 * widthRatio, height: 160 * heightRatio)
                                    .shadow(color: Color(.fsBlack).opacity(0.1), radius: 4, y: 4 * heightRatio)
                                Text(playStoryViewModel.selectedPage?.pageText.first?.componentContent ?? "")
                                    .frame(width: 700 * widthRatio, height: 160 * heightRatio)
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.center)
                                    .font(Font.custom("Fredoka", size: 32 * heightRatio, relativeTo: .title))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color("FSBlack"))
                            }
                            .padding(.bottom, 32 * heightRatio)
                            
                        } else {
                            
                            ZStack {
                                PlayStoryUpperRoundedRectangle(cornerRadius: 40 * heightRatio)
                                    .foregroundStyle(Color("FSWhite"))
                                    .frame(width: 1194 * widthRatio, height: 159 * heightRatio)
                                    .shadow(color: Color(.fsBlack).opacity(0.1), radius: 10, y: -4 * heightRatio)
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
                    .ignoresSafeArea()
                }
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
