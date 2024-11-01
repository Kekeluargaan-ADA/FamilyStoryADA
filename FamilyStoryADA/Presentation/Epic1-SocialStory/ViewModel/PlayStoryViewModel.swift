//
//  PlayStoryViewModel.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 20/10/24.
//

import Foundation
import AVFoundation

class PlayStoryViewModel: Imageable, ObservableObject {
    @Published var story: StoryEntity
    @Published var selectedPage: PageEntity?
    @Published var currentPageNumber: Int
    @Published var isStoryCompleted: Bool = false
    @Published var videoPlayer: AVPlayer = AVPlayer()
    
    init(story: StoryEntity) {
        self.story = story
        self.currentPageNumber = 0
        if let firstPage = story.pages.first {
            selectedPage = firstPage
            
        }
    }
    
    public func continueToPreviousPage() {
        guard currentPageNumber > 0 else {
            return
        }
        currentPageNumber -= 1
        selectedPage = self.story.pages[currentPageNumber]
        
    }
    
    public func continueToNextPage() {
        guard currentPageNumber < story.pages.count-1 else {
            return
        }
        currentPageNumber += 1
        selectedPage = self.story.pages[currentPageNumber]
    }
    
    func setupPlayer(url: URL) {
        self.videoPlayer = AVPlayer(url: url)
        self.videoPlayer.play()
        
        // Add observer to loop the video
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: self.videoPlayer.currentItem,
            queue: .main
        ) { _ in
            self.videoPlayer.seek(to: .zero)
            self.videoPlayer.play()
        }
    }

    func removePlayerObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: .AVPlayerItemDidPlayToEndTime,
            object: self.videoPlayer.currentItem
        )
    }
    
}
