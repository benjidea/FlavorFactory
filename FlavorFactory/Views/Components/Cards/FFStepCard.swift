import SwiftUI

struct FFStepCard: View {
    let step: Step
    var scaleFactor: Double = 1.0
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Text("Schritt \(step.order)")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.orange)
                Spacer()
            }
            // Bild anzeigen, falls vorhanden (nur iOS)
            #if canImport(UIKit)
                if let imageData = step.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .cornerRadius(8)
                }
            #endif
            Text(step.text)
                .font(.body)
                .foregroundStyle(.primary)
            if let ingredients = step.ingredients, !ingredients.isEmpty {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(ingredients) { ingredient in
                        FFStepIngredientRow(ingredient: ingredient, scaleFactor: scaleFactor)
                    }
                }
                .padding(.leading, Spacing.size1)
            }
        }
        .padding(Spacing.size3)
        .background(Color.secondary.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    FFStepCard(step: Step(
        text: "Pasta in Salzwasser kochen",
        image: UIImage(named: "step_1")?.pngData(),
        order: 1,
        ingredients: [
            Ingredient(title: "Spaghetti", amount: 500, unit: .gram),
            Ingredient(title: "Salz", amount: 1, unit: .tablespoon),
        ]
    ), scaleFactor: 1.5)
        .padding(Spacing.size3)
}
