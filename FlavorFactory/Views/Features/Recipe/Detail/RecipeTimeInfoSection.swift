import SwiftUI

/// A view that displays preparation time, cooking time, and total time information for a recipe
struct RecipeTimeInfoSection: View {
    let recipe: Recipe
    let onFavoriteToggle: () -> Void

    var body: some View {
        if let prepTime = recipe.preparationTime,
           let cookTime = recipe.cookingTime
        {
            HStack(spacing: Spacing.lg) {
                FFTimeInfo(title: "Zubereitung", time: prepTime)
                FFTimeInfo(title: "Kochzeit", time: cookTime)
                FFTimeInfo(title: "Gesamt", time: prepTime + cookTime)
                Spacer()
                Button(action: onFavoriteToggle) {
                    Image(systemName: recipe.isFavorite ? "star.fill" : "star")
                        .foregroundStyle(recipe.isFavorite ? .yellow : .gray)
                        .font(.title2)
                }
            }
        }
    }
}

#Preview {
    RecipeTimeInfoSection(
        recipe: .preview,
        onFavoriteToggle: {}
    )
    .padding()
}
