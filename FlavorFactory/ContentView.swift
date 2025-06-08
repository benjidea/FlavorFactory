//
//  ContentView.swift
//  FlavorFactory
//
//  Created by Benedikt Hruschka on 30.05.25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var selectedRecipe: Recipe?
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        NavigationSplitView {
            RecipeListView(selection: $selectedRecipe)
        } detail: {
            if let recipe = selectedRecipe {
                RecipeDetailView(recipe: recipe)
            } else {
                FFText("Wähle ein Rezept aus")
                    .navigationTitle("Rezept")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewData.shared.modelContainer)
}
