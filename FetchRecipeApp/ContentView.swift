//
//  ContentView.swift
//  FetchRecipeApp
//
//  Created by Jerry on 1/29/25.
//

import SwiftUI

struct ContentView: View {
    @State private var recipes: [Recipe] = []
    @State private var errorMessage: String?
    @State private var isLoading = false // Tracks whether data is loading

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    // Show loading indicator while fetching recipes
                    ProgressView("Loading...")
                        .scaleEffect(1.5) // Optional: Make the progress indicator larger
                        .padding()
                } else if let errorMessage = errorMessage {
                    // Show error message
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if recipes.isEmpty {
                    // Show "No recipes available" message
                    Text("No recipes available.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    // Show list of recipes
                    List(recipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeRow(recipe: recipe)
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Refresh") {
                        Task {
                            isLoading = true
                            await loadRecipes()
                            isLoading = false
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    isLoading = true
                    await loadRecipes()
                    isLoading = false
                }
            }
        }
    }

    private func loadRecipes() async {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!

        do {
            let fetchedRecipes = try await RecipeService.shared.fetchRecipes(from: url)
            
            if fetchedRecipes.isEmpty {
                errorMessage = "No recipes available."
                recipes = []
            } else {
                errorMessage = nil
                recipes = fetchedRecipes
            }
        } catch let decodingError as DecodingError {
            // Handle specific decoding errors with more details
            switch decodingError {
            case .dataCorrupted(let context):
                errorMessage = "Malformed data: \(context.debugDescription)"
            case .keyNotFound(let key, let context):
                errorMessage = "Missing key '\(key.stringValue)': \(context.debugDescription)"
            case .typeMismatch(_, let context):
                errorMessage = "Type mismatch: \(context.debugDescription)"
            case .valueNotFound(_, let context):
                errorMessage = "Value not found: \(context.debugDescription)"
            @unknown default:
                errorMessage = "Unknown decoding error"
            }
            recipes = []
        } catch {
            // Handle all other errors
            errorMessage = "Failed to load recipes: \(error.localizedDescription)"
            recipes = []
        }
    }
}

struct RecipeRow: View {
    let recipe: Recipe
    @State private var image: UIImage?

    var body: some View {
        HStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
            } else {
                ProgressView()
                    .frame(width: 50, height: 50)
            }

            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        guard let urlString = recipe.photoUrlSmall, let url = URL(string: urlString) else { return }
        Task {
            if let loadedImage = try? await ImageCache.shared.loadImage(from: url) {
                image = loadedImage
            }
        }
    }
}

