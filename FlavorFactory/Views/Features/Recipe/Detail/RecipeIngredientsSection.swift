import SwiftUI

/// A view that displays the ingredients list with portion adjustment controls
struct RecipeIngredientsSection: View {
    let recipe: Recipe
    let portions: Int
    let scaleFactor: Double
    let onPortionsIncrease: () -> Void
    let onPortionsDecrease: () -> Void

    var body: some View {
        if !recipe.uniqueIngredients.isEmpty {
            VStack(alignment: .leading, spacing: Spacing.size3) {
                HStack {
                    FFSectionHeader(text: "Zutaten")
                    Spacer()
                    HStack(spacing: Spacing.size2) {
                        Button(action: onPortionsDecrease) {
                            Image(systemName: "minus.circle.fill")
                                .foregroundStyle(.gray)
                        }
                        FFText("\(portions) Portionen", style: .caption)
                            .foregroundStyle(.secondary)
                        Button(action: onPortionsIncrease) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                ForEach(recipe.uniqueIngredients) { ingredient in
                    FFIngredientRow(ingredient: ingredient, scaleFactor: scaleFactor)
                }
            }
        }
    }
}

#Preview {
    RecipeIngredientsSection(
        recipe: .preview,
        portions: 4,
        scaleFactor: 1.0,
        onPortionsIncrease: {},
        onPortionsDecrease: {}
    )
    .padding()
}
