//
//  RecipeService.swift
//  FetchRecipeApp
//
//  Created by Jerry on 1/29/25.
//

import Foundation

final class RecipeService {
    static let shared = RecipeService()  // Singleton for easy access
    private init() {}

    func fetchRecipes(from url: URL) async throws -> [Recipe] {
        do {
            // Fetch data from the URL
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Validate HTTP response
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            // Decode the JSON response into RecipeResponse
            do {
                let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                return decodedResponse.recipes
            } catch let decodingError as DecodingError {
                // Handle decoding errors specifically for malformed data
                print("Decoding Error: \(decodingError)")
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: [],
                        debugDescription: "Malformed data. Failed to decode the recipes."
                    )
                )
            }
        } catch {
            // Log other errors (e.g., network failures) for debugging
            print("Error fetching recipes: \(error.localizedDescription)")
            throw error // Propagate the error for further handling
        }
    }
}

