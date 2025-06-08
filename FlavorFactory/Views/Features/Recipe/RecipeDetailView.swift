import SwiftData
import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @Environment(\.modelContext) private var modelContext
    @State private var preparedDTO: RecipeDTO?
    @State private var portions: Int

    init(recipe: Recipe) {
        self.recipe = recipe
        _portions = State(initialValue: recipe.portions)
    }

    private var scaleFactor: Double {
        Double(portions) / Double(recipe.portions)
    }

    var body: some View {
        ScrollView {
            VStack {
                CoverImageHeader(recipe: recipe)
                VStack(alignment: .leading, spacing: Spacing.size4) {
                    RecipeTimeInfoSection(
                        recipe: recipe,
                        onFavoriteToggle: toggleFavorite
                    )

                    if !recipe.tags.isEmpty {
                        FFTagList(tags: recipe.tags)
                    }

                    RecipeIngredientsSection(
                        recipe: recipe,
                        portions: portions,
                        scaleFactor: scaleFactor,
                        onPortionsIncrease: increasePortions,
                        onPortionsDecrease: decreasePortions
                    )

                    RecipeStepsSection(
                        recipe: recipe,
                        scaleFactor: scaleFactor
                    )

                    if let notes = recipe.notes, !notes.isEmpty {
                        FFNotesCard(notes: notes)
                    }
                }
                .padding(Spacing.size3)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if let dto = preparedDTO {
                    ShareLink(
                        item: dto,
                        preview: SharePreview(
                            "\(recipe.title).json",
                            image: Image(systemName: "doc.text")
                        )
                    )
                } else {
                    ProgressView()
                        .controlSize(.small)
                }
            }
        }
        .task {
            preparedDTO = recipe.toDTO(includeImages: true)
        }
    }

    private func toggleFavorite() {
        recipe.isFavorite.toggle()
    }

    private func increasePortions() {
        portions += 1
    }

    private func decreasePortions() {
        if portions > 1 {
            portions -= 1
        }
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: .preview)
    }
    .modelContainer(PreviewData.shared.modelContainer)
}
