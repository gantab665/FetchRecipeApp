//
//  Recipe.swift
//  FetchRecipeApp
//
//  Created by Jerry on 1/29/25.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let uuid: String
    let name: String
    let cuisine: String
    let photoUrlSmall: String?
    let photoUrlLarge: String?
    let sourceUrl: String?      // Add this property
    let youtubeUrl: String?     // Add this property

    var id: String { uuid } // Use `uuid` as the `id`

    private enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case cuisine
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
        case sourceUrl = "source_url" // Map JSON key to Swift property
        case youtubeUrl = "youtube_url" // Map JSON key to Swift property
    }
}

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

