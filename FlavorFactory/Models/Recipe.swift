import Foundation
import SwiftData

/// Represents a recipe in the app
@Model
final class Recipe {
    // MARK: - Basic Information

    var title: String = ""
    var course: Course = Course.main
    var dietaryType: DietaryType = DietaryType.omnivore
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

    // MARK: - Initialization

    init(
        title: String = "",
        course: Course = Course.main,
        dietaryType: DietaryType = DietaryType.omnivore,
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
        steps: [Step]? = []
    ) {
        self.title = title
        self.course = course
        self.dietaryType = dietaryType
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

enum DietaryType: String, Codable {
    case vegetarian
    case vegan
    case pescatarian
    case omnivore
    case other
}

enum RecipeDifficulty: String, Codable {
    case easy
    case medium
    case hard
}
