import Foundation
import SwiftData

/// Represents a recipe in the app
@Model
final class Recipe {
    // MARK: - Basic Information

    var title: String = ""
    var course: Course = Course.main
    var diet: Diet = Diet.other
    var portions: Int = 1
    var rating: Double?

    // MARK: - Metadata

    var creationDate: Date = Date.now
    var lastModifiedDate: Date = Date.now
    var lastCookedDate: Date?
    var cookingHistory: [Date] = []
    var notes: String?
    var tags: [String] = []
    var isFavorite: Bool = false
    var source: String?
    var difficulty: RecipeDifficulty?

    // MARK: - Time Information

    var preparationTime: Int?
    var cookingTime: Int?

    // MARK: - Relationships

    @Relationship(deleteRule: .cascade) var steps: [Step]? = []

    // MARK: - Cover Image

    /// The cover image for the recipe (optional, stored as Data)
    var coverImage: Data?

    // MARK: - Initialization

    init(
        title: String = "",
        course: Course = Course.main,
        diet: Diet = Diet.other,
        portions: Int = 1,
        rating: Double? = nil,
        creationDate: Date = .now,
        lastModifiedDate: Date = .now,
        lastCookedDate: Date? = nil,
        cookingHistory: [Date] = [],
        notes: String? = nil,
        tags: [String] = [],
        isFavorite: Bool = false,
        source: String? = nil,
        difficulty: RecipeDifficulty? = nil,
        preparationTime: Int? = nil,
        cookingTime: Int? = nil,
        steps: [Step]? = [],
        coverImage: Data? = nil
    ) {
        self.title = title
        self.course = course
        self.diet = diet
        self.portions = portions
        self.rating = rating
        self.creationDate = creationDate
        self.lastModifiedDate = lastModifiedDate
        self.lastCookedDate = lastCookedDate
        self.cookingHistory = cookingHistory
        self.notes = notes
        self.tags = tags
        self.isFavorite = isFavorite
        self.source = source
        self.difficulty = difficulty
        self.preparationTime = preparationTime
        self.cookingTime = cookingTime
        self.steps = steps
        self.coverImage = coverImage
    }
}

// MARK: - Enums

enum Course: String, Codable {
    case main
    case dessert
    case appetizer
    case soup
    case salad
    case side
    case breakfast
    case snack
    case other
}

/// Represents the dietary type of a recipe
enum Diet: String, Codable, CaseIterable {
    case beef
    case fish
    case lamb
    case pork
    case poultry
    case seafood
    case vegan
    case vegetarian
    case other
}

enum RecipeDifficulty: String, Codable {
    case easy
    case medium
    case hard
}

extension Recipe {
    var uniqueIngredients: [Ingredient] {
        guard let steps = steps else { return [] }
        let allIngredients = steps.flatMap { $0.ingredients ?? [] }

        // Group ingredients by title and aggregate amounts
        let groupedIngredients = Dictionary(grouping: allIngredients) { $0.title }
        return groupedIngredients.map { title, ingredients in
            let totalAmount = ingredients.reduce(0) { $0 + ($1.amount) }
            let firstIngredient = ingredients[0]
            return Ingredient(
                title: title,
                amount: totalAmount,
                unit: firstIngredient.unit
            )
        }.sorted { (ingredient1: Ingredient, ingredient2: Ingredient) in
            // First sort by availability (unavailable first)
            if ingredient1.available != ingredient2.available {
                return !ingredient1.available
            }
            // Then alphabetically
            return ingredient1.title.localizedCaseInsensitiveCompare(ingredient2.title) == .orderedAscending
        }
    }
}
