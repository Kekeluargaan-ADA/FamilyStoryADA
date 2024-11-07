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
    @Published var draggedPages: [DraggablePage] = []
    @Published var correctAnswer: [DraggablePage] = []
    @Published var currentlyCheckedIndex: Int = 0
    
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
}
