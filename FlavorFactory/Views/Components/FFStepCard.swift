import SwiftUI

struct FFStepCard: View {
    let step: Step
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Text("Schritt \(step.order)")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.orange)
                Spacer()
            }
            Text(step.text)
                .font(.body)
                .foregroundStyle(.primary)
            if let ingredients = step.ingredients, !ingredients.isEmpty {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(ingredients) { ingredient in
                        FFIngredientRow(ingredient: ingredient)
                    }
                }
                .padding(.leading, 4)
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    FFStepCard(step: Step(
        text: "Pasta in Salzwasser kochen",
        order: 1,
        ingredients: [
            Ingredient(title: "Spaghetti", amount: 500, unit: .gram),
            Ingredient(title: "Salz", amount: 1, unit: .tablespoon),
        ]
    ))
    .padding()
}
