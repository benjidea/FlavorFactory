import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                FFH3(text: recipe.title)
                    .font(.headline)
                HStack(spacing: Spacing.sm) {
                    FFIconLabel(systemImage: "fork.knife", text: recipe.course.rawValue)
                    FFIconLabel(systemImage: "leaf", text: recipe.dietaryType.rawValue)
                    if recipe.isFavorite {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                    }
                }
                if !recipe.tags.isEmpty {
                    FFTagList(tags: Array(recipe.tags.prefix(2)))
                }
            }
            Spacer()
            if let rating = recipe.rating {
                Text(String(format: "%.1f", rating))
                    .font(.headline)
                    .foregroundStyle(.orange)
            }
        }
        .padding(.vertical, Spacing.xs)
    }
}

#Preview {
    RecipeRowView(recipe: .preview)
        .padding(Spacing.md)
}
