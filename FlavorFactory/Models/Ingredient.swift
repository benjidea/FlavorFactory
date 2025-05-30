import Foundation
import SwiftData

/// Represents an ingredient used in a recipe step
@Model
final class Ingredient {
    // MARK: - Properties

    var title: String = ""
    var amount: Double = 0.0
    var unit: IngredientUnit?
    var available: Bool = false

    // MARK: - Relationships

    @Relationship(inverse: \Step.ingredients) var step: Step? = nil

    // MARK: - Initialization

    init(
        title: String = "",
        amount: Double = 0.0,
        unit: IngredientUnit? = nil,
        available: Bool = false,
        step: Step? = nil
    ) {
        self.title = title
        self.amount = amount
        self.unit = unit
        self.available = available
        self.step = step
    }
}

// MARK: - Enums

enum IngredientUnit: String, Codable {
    case gram = "g"
    case milliliter = "ml"
    case teaspoon = "tsp"
    case tablespoon = "tbsp"
    case piece
    case cup
    case can
    case pinch
    case slice
    case bunch
    case pack
    case jar
    case centimeter = "cm"
    case liter = "l"
    case kilogram = "kg"
    case dash
}
