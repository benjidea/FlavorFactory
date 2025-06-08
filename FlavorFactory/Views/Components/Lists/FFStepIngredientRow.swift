import SwiftUI

struct FFStepIngredientRow: View {
    let ingredient: Ingredient
    var scaleFactor: Double = 1.0

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 6) {
            FFText("•")
            FFText(ingredient.title)
                .fontWeight(.medium)
            if ingredient.amount > 0 {
                amount
            }
        }
        .font(.callout)
    }

    @ViewBuilder
    private var amount: some View {
        FFText(amountText)
            .foregroundStyle(.secondary)
        if let unit = ingredient.unit {
            FFText(unit.rawValue)
                .foregroundStyle(.secondary)
        }
    }

    private var amountText: String {
        AmountFormattingUseCaseImpl()(ingredient.amount * scaleFactor)
    }
}

#Preview {
    VStack(alignment: .leading) {
        FFStepIngredientRow(ingredient: Ingredient(title: "Spaghetti", amount: 500, unit: .gram), scaleFactor: 1.0)
        FFStepIngredientRow(ingredient: Ingredient(title: "Salz", amount: 1, unit: .tablespoon), scaleFactor: 2.0)
        FFStepIngredientRow(ingredient: Ingredient(title: "Eier", amount: 3, unit: .piece), scaleFactor: 0.5)
    }
    .padding(Spacing.size3)
}
