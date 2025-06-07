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
            VStack(alignment: .leading, spacing: Spacing.lg) {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    HStack(alignment: .top) {
                        FFTitle(text: recipe.title)
                        Spacer()
                        Button(action: toggleFavorite) {
                            Image(systemName: recipe.isFavorite ? "star.fill" : "star")
                                .foregroundStyle(recipe.isFavorite ? .yellow : .gray)
                                .font(.title2)
                        }
                    }
                    HStack(spacing: Spacing.sm) {
                        FFIconLabel(systemImage: "fork.knife", text: recipe.course.rawValue)
                        Text("•")
                        FFIconLabel(systemImage: "leaf", text: recipe.dietaryType.rawValue)
                        if let difficulty = recipe.difficulty {
                            Text("•")
                            FFIconLabel(systemImage: "chart.bar", text: difficulty.rawValue)
                        }
                    }
                }
                if let prepTime = recipe.preparationTime,
                   let cookTime = recipe.cookingTime
                {
                    HStack(spacing: Spacing.lg) {
                        FFTimeInfo(title: "Zubereitung", time: prepTime)
                        FFTimeInfo(title: "Kochzeit", time: cookTime)
                        FFTimeInfo(title: "Gesamt", time: prepTime + cookTime)
                    }
                }
                if !recipe.tags.isEmpty {
                    FFTagList(tags: recipe.tags)
                }
                if !recipe.uniqueIngredients.isEmpty {
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        HStack {
                            FFSectionHeader(text: "Zutaten")
                            Spacer()
                            HStack(spacing: Spacing.sm) {
                                Button(action: decreasePortions) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundStyle(.gray)
                                }
                                Text("\(portions) Portionen")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Button(action: increasePortions) {
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
                if let steps = recipe.steps, !steps.isEmpty {
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        FFSectionHeader(text: "Zubereitung")
                        ForEach(steps.sorted(by: { $0.order < $1.order })) { step in
                            FFStepCard(step: step, scaleFactor: scaleFactor)
                        }
                    }
                }
                if let notes = recipe.notes, !notes.isEmpty {
                    FFNotesBox(notes: notes)
                }
            }
            .padding(Spacing.md)
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
