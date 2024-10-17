//
//  PagesJSONObject.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 09/10/24.
//

import Foundation

struct PageJSONObject: Codable, IJSONAble {
    let pageText: [ComponentJSONObject]
    let pagePicture: [ComponentJSONObject]
    let pageVideo: [ComponentJSONObject]
    let pageSoundPath: String
}
