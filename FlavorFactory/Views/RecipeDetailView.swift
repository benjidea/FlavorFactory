import SwiftData
import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @Environment(\.modelContext) private var modelContext
    @State private var preparedDTO: RecipeDTO?

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
                if let steps = recipe.steps, !steps.isEmpty {
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        FFSectionHeader(text: "Zubereitung")
                        ForEach(steps.sorted(by: { $0.order < $1.order })) { step in
                            FFStepCard(step: step)
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
}

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: .preview)
    }
    .modelContainer(PreviewData.shared.modelContainer)
}
