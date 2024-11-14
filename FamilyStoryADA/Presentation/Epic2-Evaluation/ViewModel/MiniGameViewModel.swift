//
//  MiniGameViewModel.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 06/11/24.
//

import Foundation
import UIKit
import SwiftUI

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
        print("\(fileName)")
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
        self.correctAnswer = DraggablePage.fetchDraggedPage(story: story)
        self.draggedPages = DraggablePage.fetchDraggedPage(story: story).shuffled()
        self.currentlyCheckedIndex = 0
        self.isAllCorrect = false
        printID()
    }
    
    public func startTutorialTimer() {
        tutorialTimer?.invalidate() // Ensure any previous timer is canceled
        tutorialTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
            DispatchQueue.main.async {
                withAnimation(.easeIn(duration: 0.3)) { // Add easeIn animation
                    self.isTutorialShown = true
                }
            }
        }
    }
    
    // Function to restart the timer (used when overlay is tapped)
    public func restartTutorialTimer() {
        self.isTutorialShown = false // Set tutorial to false on tap
        startTutorialTimer() // Restart the timer for another 10 seconds
    }
    
    private func printID() {
        print("Correct Answer")
        for page in correctAnswer {
            print("\(String(describing: page.id)): \(page.picturePath)")
        }
        print("Shuffled Answer")
        for page in draggedPages {
            print("\(String(describing: page.id)): \(page.picturePath)")
        }
        print("---------------------------------------------")
    }
}
