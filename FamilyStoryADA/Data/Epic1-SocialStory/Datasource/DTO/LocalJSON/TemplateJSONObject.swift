//
//  TemplateJSONObject.swift
//  FamilyStoryADA
//
//  Created by Nathanael Juan Gauthama on 09/10/24.
//

import Foundation

struct TemplateJSONObject: Codable {
    let templateId: String
    let templateName: String
    let templatePage: [PageJSONObject]
}
