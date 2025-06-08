import SwiftUI

/// A view that displays the preparation steps for a recipe
struct RecipeStepsSection: View {
    let recipe: Recipe
    let scaleFactor: Double

    var body: some View {
        if let steps = recipe.steps, !steps.isEmpty {
            VStack(alignment: .leading, spacing: Spacing.md) {
                FFSectionHeader(text: "Zubereitung")
                ForEach(steps.sorted(by: { $0.order < $1.order })) { step in
                    FFStepCard(step: step, scaleFactor: scaleFactor)
                }
            }
        }
    }
}

#Preview {
    RecipeStepsSection(
        recipe: .preview,
        scaleFactor: 1.0
    )
    .padding()
}
