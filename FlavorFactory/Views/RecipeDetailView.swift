import SwiftData
import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top) {
                        FFTitle(text: recipe.title)
                        Spacer()
                        Button(action: toggleFavorite) {
                            Image(systemName: recipe.isFavorite ? "star.fill" : "star")
                                .foregroundStyle(recipe.isFavorite ? .yellow : .gray)
                                .font(.title2)
                        }
                    }
                    HStack(spacing: 8) {
                        FFIconLabel(systemImage: "fork.knife", text: recipe.course.rawValue)
                        Text("•")
                        FFIconLabel(systemImage: "leaf", text: recipe.dietaryType.rawValue)
                        if let difficulty = recipe.difficulty {
                            Text("•")
                            FFIconLabel(systemImage: "chart.bar", text: difficulty.rawValue)
                        }
                    }
                }
                // Time Information
                if let prepTime = recipe.preparationTime,
                   let cookTime = recipe.cookingTime
                {
                    HStack(spacing: 24) {
                        FFTimeInfo(title: "Zubereitung", time: prepTime)
                        FFTimeInfo(title: "Kochzeit", time: cookTime)
                        FFTimeInfo(title: "Gesamt", time: prepTime + cookTime)
                    }
                }
                // Tags
                if !recipe.tags.isEmpty {
                    FFTagList(tags: recipe.tags)
                }
                // Steps
                if let steps = recipe.steps, !steps.isEmpty {
                    VStack(alignment: .leading, spacing: 20) {
                        FFSectionHeader(text: "Zubereitung")
                        ForEach(steps.sorted(by: { $0.order < $1.order })) { step in
                            FFStepCard(step: step)
                        }
                    }
                }
                // Notes
                if let notes = recipe.notes, !notes.isEmpty {
                    FFNotesBox(notes: notes)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
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
