import Foundation

struct IngredientDTO: Codable {
    let title: String
    let amount: Double
    let unit: String?
    let available: Bool?
}

struct StepDTO: Codable {
    let text: String
    let image: String? // Base64-codiert
    let order: Int
    let ingredients: [IngredientDTO]
}

struct RecipeDTO: Codable {
    let title: String
    let course: String
    let dietaryType: String
    let portions: Int
    let rating: Double?
    let creationDate: String
    let lastModifiedDate: String
    let lastCookedDate: String?
    let cookingHistory: [String]
    let notes: String?
    let tags: [String]
    let isFavorite: Bool
    let source: String?
    let difficulty: String?
    let preparationTime: Int?
    let cookingTime: Int?
    let steps: [StepDTO]
}

extension Recipe {
    func toDTO() -> RecipeDTO {
        RecipeDTO(
            title: title,
            course: course.rawValue,
            dietaryType: dietaryType.rawValue,
            portions: portions,
            rating: rating,
            creationDate: ISO8601DateFormatter().string(from: creationDate),
            lastModifiedDate: ISO8601DateFormatter().string(from: lastModifiedDate),
            lastCookedDate: lastCookedDate != nil ? ISO8601DateFormatter().string(from: lastCookedDate!) : nil,
            cookingHistory: cookingHistory.map { ISO8601DateFormatter().string(from: $0) },
            notes: notes,
            tags: tags,
            isFavorite: isFavorite,
            source: source,
            difficulty: difficulty?.rawValue,
            preparationTime: preparationTime,
            cookingTime: cookingTime,
            steps: (steps ?? []).map { $0.toDTO() }
        )
    }
}

extension Step {
    func toDTO() -> StepDTO {
        StepDTO(
            text: text,
            image: image?.base64EncodedString(),
            order: order,
            ingredients: (ingredients ?? []).map { $0.toDTO() }
        )
    }
}

extension Ingredient {
    func toDTO() -> IngredientDTO {
        IngredientDTO(
            title: title,
            amount: amount,
            unit: unit?.rawValue,
            available: available
        )
    }
}
