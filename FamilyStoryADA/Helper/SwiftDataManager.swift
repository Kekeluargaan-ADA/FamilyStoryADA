//
//  SwiftDataManager.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 14/10/24.
//

import Foundation
import SwiftData


public class SwiftDataManager {
    public static var shared = SwiftDataManager()
    var container: ModelContainer
    var context: ModelContext
    
    init() {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
            container = try ModelContainer(for: UserSwiftData.self,
                                           StorySwiftData.self,
                                           PageSwiftData.self,
                                           StoryComponentSwiftData.self,
                                           RatioSwiftData.self,
                                           configurations: configuration)
            context = ModelContext(container)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
