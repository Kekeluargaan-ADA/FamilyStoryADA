//
//  FamilyStoryADAApp.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 23/09/24.
//

import SwiftUI
import SwiftData

@main
struct FamilyStoryADAApp: App {
    var body: some Scene {
        WindowGroup {
//            ExampleCropView()
            CameraView()
//                .onAppear() {
//                    let fileManager = FileManager.default
//                    let url = "4ECBB088-FD5C-42CF-8C5C-5AE0D6EC5962.jpg"
//                    if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
//                        let fileURL = documentsDirectory.appendingPathComponent(url)
//                        if fileManager.fileExists(atPath: fileURL.path) {
//                            print("Success: Image saved and verified at \(fileURL.path)")
//                        } else {
//                            print("Error: Image file not found at \(fileURL.path) after saving.")
//                        }
//                    }
//                }
        }
        .modelContainer(for:
                User.self

        )
    }
}
