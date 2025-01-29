//
//  RecipeDetailView.swift
//  FetchRecipeApp
//
//  Created by Jerry on 1/29/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let photoUrlLarge = recipe.photoUrlLarge, let url = URL(string: photoUrlLarge) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 200)
                    .cornerRadius(8)
                }

                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Cuisine: \(recipe.cuisine)")
                    .font(.title3)
                    .foregroundColor(.gray)

                if let sourceUrl = recipe.sourceUrl, let url = URL(string: sourceUrl) {
                    Link("View Source", destination: url)
                        .font(.body)
                        .foregroundColor(.blue)
                }

                if let youtubeUrl = recipe.youtubeUrl, let url = URL(string: youtubeUrl) {
                    Link("Watch on YouTube", destination: url)
                        .font(.body)
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
        .navigationTitle("Recipe Details")
    }
}

