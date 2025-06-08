import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: Spacing.size1) {
                FFH3(recipe.title)
                    .font(.headline)
                HStack(spacing: Spacing.size2) {
                    FFIconLabel(systemImage: "fork.knife", text: recipe.course.rawValue)
                    HStack(spacing: Spacing.size1) {
                        FFDietIconLabel(diet: recipe.diet)
                    }
                    if recipe.isFavorite {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                    }
                }
                if !recipe.tags.isEmpty {
                    FFTagList(tags: Array(recipe.tags.prefix(2)), layout: .flow)
                }
            }
            Spacer()
            if let rating = recipe.rating {
                Text(String(format: "%.1f", rating))
                    .font(.headline)
                    .foregroundStyle(.orange)
            }
        }
        .padding(.vertical, Spacing.size1)
    }
}

#Preview {
    RecipeRowView(recipe: .preview)
        .padding(Spacing.size3)
}
