//
//  DraggablePage.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 11/10/24.
//

import Foundation
import UniformTypeIdentifiers
import CoreTransferable

struct DraggablePage: Codable {
    
    let id: UUID
    let picturePath: String
    
    
    // debug function
    static func loadDummyData() -> [DraggablePage] {
        return [
            DraggablePage(id: UUID(uuidString: "819f2cc6-345d-4bfa-b081-2b0d4afc53ac") ?? UUID(), picturePath: "DummyImage"),
            DraggablePage(id: UUID(), picturePath: "DummyImage2"),
            DraggablePage(id: UUID(), picturePath: "DummyImage3"),
        ]
    }
    
    static func loadEmptyArray() -> [DraggablePage] {
        return [
            DraggablePage(id: UUID(uuidString: "") ?? UUID(), picturePath: ""),
            DraggablePage(id: UUID(uuidString: "") ?? UUID(), picturePath: ""),
            DraggablePage(id: UUID(uuidString: "") ?? UUID(), picturePath: ""),
            DraggablePage(id: UUID(uuidString: "") ?? UUID(), picturePath: ""),
            DraggablePage(id: UUID(uuidString: "") ?? UUID(), picturePath: ""),
            DraggablePage(id: UUID(uuidString: "") ?? UUID(), picturePath: ""),
            DraggablePage(id: UUID(uuidString: "") ?? UUID(), picturePath: ""),
            DraggablePage(id: UUID(uuidString: "") ?? UUID(), picturePath: ""),
            DraggablePage(id: UUID(uuidString: "") ?? UUID(), picturePath: ""),
            DraggablePage(id: UUID(uuidString: "") ?? UUID(), picturePath: ""),
        ]
    }
}

extension DraggablePage: Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .draggablePage)
    }
}

extension UTType {
    static var draggablePage = UTType(exportedAs: "\(Project.bundleIdentifier).draggablePage")
}


