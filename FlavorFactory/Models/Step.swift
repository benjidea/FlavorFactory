import Foundation
import SwiftData

/// Represents a single step in a recipe
@Model
final class Step {
    // MARK: - Properties

    var text: String = ""
    var image: String?
    var order: Int = 0

    // MARK: - Relationships

    @Relationship(deleteRule: .cascade) var ingredients: [Ingredient]? = []
    @Relationship(inverse: \Recipe.steps) var recipe: Recipe? = nil

    // MARK: - Initialization

    init(
        text: String = "",
        image: String? = nil,
        order: Int = 0,
        ingredients: [Ingredient]? = [],
        recipe: Recipe? = nil
    ) {
        self.text = text
        self.image = image
        self.order = order
        self.ingredients = ingredients
        self.recipe = recipe
    }
}
