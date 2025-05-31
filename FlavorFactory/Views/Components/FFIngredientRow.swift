import SwiftUI

struct FFIngredientRow: View {
    let ingredient: Ingredient
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 6) {
            Text("•")
            Text(ingredient.title)
                .fontWeight(.medium)
            if let unit = ingredient.unit {
                Text("\(ingredient.amount.cleanAmount) \(unit.rawValue)")
                    .foregroundStyle(.secondary)
            } else {
                Text("\(ingredient.amount.cleanAmount)")
                    .foregroundStyle(.secondary)
            }
        }
        .font(.callout)
    }
}

#Preview {
    VStack(alignment: .leading) {
        FFIngredientRow(ingredient: Ingredient(title: "Spaghetti", amount: 500, unit: .gram))
        FFIngredientRow(ingredient: Ingredient(title: "Salz", amount: 1, unit: .tablespoon))
        FFIngredientRow(ingredient: Ingredient(title: "Eier", amount: 4, unit: .piece))
    }
    .padding()
}
