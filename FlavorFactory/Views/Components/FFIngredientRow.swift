import SwiftUI

struct FFIngredientRow: View {
    let ingredient: Ingredient
    var scaleFactor: Double = 1.0

    var body: some View {
        HStack {
            Text(ingredient.title)
            Spacer()
            if ingredient.amount > 0 {
                amount
            }
        }
        .foregroundStyle(ingredient.available ? .primary : .secondary)
    }

    @ViewBuilder
    private var amount: some View {
        Text(amountText)
            .foregroundStyle(.secondary)
        if let unit = ingredient.unit {
            Text(unit.rawValue)
                .foregroundStyle(.secondary)
        }
    }

    private var amountText: String {
        AmountFormattingUseCaseImpl()(ingredient.amount * scaleFactor)
    }
}

#Preview {
    VStack(alignment: .leading) {
        FFIngredientRow(ingredient: Ingredient(title: "Spaghetti", amount: 500, unit: .gram))
        FFIngredientRow(ingredient: Ingredient(title: "Salz", amount: 1, unit: .tablespoon))
        FFIngredientRow(ingredient: Ingredient(title: "Eier", amount: 3.5, unit: .piece))
    }
    .padding(Spacing.md)
}
