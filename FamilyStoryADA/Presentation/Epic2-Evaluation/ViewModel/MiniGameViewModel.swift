//
//  MiniGameViewModel.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 06/11/24.
//

import Foundation
import UIKit

class MiniGameViewModel: Imageable, ObservableObject {
    @Published var story: StoryEntity
    @Published var isDismissed: Bool = false
    @Published var isAllCorrect: Bool = false
    @Published var isTutorialShown: Bool = false
    @Published var draggedPages: [DraggablePage] = []
    @Published var correctAnswer: [DraggablePage] = []
    @Published var currentlyCheckedIndex: Int = 0
    
    @Published var tutorialTimer: Timer?
    
    init(story: StoryEntity) {
        self.story = story
        self.correctAnswer = DraggablePage.fetchDraggedPage(story: story)
        self.draggedPages = DraggablePage.fetchDraggedPage(story: story).shuffled()
    }
    
    public func displayImage(fileName: String) -> UIImage? {
        var image = UIImage()
        guard fileName != "" else { return nil }
        if let imageAppStorage = loadImageFromDiskWith(fileName: fileName) {
            image = imageAppStorage
        } else {
            image = UIImage(imageLiteralResourceName: fileName)
        }
        
        return image
    }
    
    public func resetGame() {
        self.draggedPages = DraggablePage.fetchDraggedPage(story: story).shuffled()
        self.currentlyCheckedIndex = 0
        self.isAllCorrect = false
    }
    
    public func startTutorialTimer() {
        tutorialTimer?.invalidate() // Ensure any previous timer is canceled
        tutorialTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
            self.isTutorialShown = true
        }
    }
    
    // Function to restart the timer (used when overlay is tapped)
    public func restartTutorialTimer() {
        self.isTutorialShown = false // Set tutorial to false on tap
        startTutorialTimer() // Restart the timer for another 10 seconds
    }
}
