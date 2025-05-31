import Foundation
import SwiftData
import SwiftUI

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

struct RecipeDTO: Codable, Transferable {
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

    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .json)
    }
}

extension Recipe {
    func toDTO(includeImages: Bool = false) -> RecipeDTO {
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
            steps: (steps ?? []).map { $0.toDTO(includeImages: includeImages) }
        )
    }
}

extension Step {
    func toDTO(includeImages: Bool = false) -> StepDTO {
        StepDTO(
            text: text,
            image: includeImages ? image?.base64EncodedString() : nil,
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

extension RecipeDTO {
    func toModel(context: ModelContext) -> Recipe {
        let recipe = Recipe(
            title: title,
            course: Course(rawValue: course) ?? .main,
            dietaryType: DietaryType(rawValue: dietaryType) ?? .omnivore,
            portions: portions,
            rating: rating,
            creationDate: ISO8601DateFormatter().date(from: creationDate) ?? .now,
            lastModifiedDate: ISO8601DateFormatter().date(from: lastModifiedDate) ?? .now,
            lastCookedDate: lastCookedDate != nil ? ISO8601DateFormatter().date(from: lastCookedDate!) : nil,
            cookingHistory: cookingHistory.compactMap { ISO8601DateFormatter().date(from: $0) },
            notes: notes,
            tags: tags,
            isFavorite: isFavorite,
            source: source,
            difficulty: difficulty != nil ? RecipeDifficulty(rawValue: difficulty!) : nil,
            preparationTime: preparationTime,
            cookingTime: cookingTime
        )
        let steps = self.steps.map { $0.toModel(context: context) }
        recipe.steps = steps
        return recipe
    }
}

extension StepDTO {
    func toModel(context: ModelContext) -> Step {
        let step = Step(
            text: text,
            image: image != nil ? Data(base64Encoded: image!) : nil,
            order: order
        )
        let ingredients = self.ingredients.map { $0.toModel(context: context) }
        step.ingredients = ingredients
        return step
    }
}

extension IngredientDTO {
    func toModel(context _: ModelContext) -> Ingredient {
        Ingredient(
            title: title,
            amount: amount,
            unit: unit != nil ? IngredientUnit(rawValue: unit!) : nil,
            available: available ?? false
        )
    }
}
