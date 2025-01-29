//
//  FetchRecipeAppTests.swift
//  FetchRecipeAppTests
//
//  Created by Jerry on 1/29/25.
//

import Testing
@testable import FetchRecipeApp
import Foundation

struct FetchRecipeAppTests {
    
    // MARK: - RecipeService Tests
    
    @Test
    func testFetchRecipesSuccess() async throws {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        let recipes = try await RecipeService.shared.fetchRecipes(from: url)
        #expect(!recipes.isEmpty, "Recipes should not be empty")
    }

    @Test
    func testFetchRecipesEmpty() async throws {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
        let recipes = try await RecipeService.shared.fetchRecipes(from: url)
        #expect(recipes.isEmpty, "Recipes should be empty")
    }

    @Test
    func testFetchRecipesMalformed() async {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
        do {
            _ = try await RecipeService.shared.fetchRecipes(from: url)
            #expect(false, "Malformed data should throw an error") // Instead of #fail
        } catch {
            #expect(error is DecodingError, "Expected a DecodingError")
        }
    }

    // MARK: - ImageCache Tests
    
    @Test
    func testLoadImageFromCache() async throws {
        let imageURL = URL(string: "https://picsum.photos/150")!
        // Simulate caching an image
        let imageData = Data([0, 1, 2, 3, 4, 5]) // Mock image data
        try FileManager.default.createDirectory(at: ImageCache.shared.cacheDirectory, withIntermediateDirectories: true)
        let cachedPath = ImageCache.shared.cacheDirectory.appendingPathComponent(imageURL.lastPathComponent)
        try imageData.write(to: cachedPath)

        // Attempt to load the image from cache
                let image = try await ImageCache.shared.loadImage(from: imageURL)
                #expect(image != nil, "Image should load successfully from cache")
    }

    @Test
    func testLoadImageFromNetwork() async throws {
        // Replace with a working URL
        let imageURL = URL(string: "https://picsum.photos/150")!

        // Attempt to load the image from the network
        do {
            let image = try await ImageCache.shared.loadImage(from: imageURL)
            #expect(image != nil, "Image should load successfully from the network")
        } catch {
            #expect(false, "Failed to load image from the network: \(error)")
        }
    }

}

