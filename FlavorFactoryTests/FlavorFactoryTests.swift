//
//  FlavorFactoryTests.swift
//  FlavorFactoryTests
//
//  Created by Benedikt Hruschka on 30.05.25.
//

@testable import FlavorFactory
import Testing

struct FlavorFactoryTests {
    @Test("Recipe DTO Konvertierung") func recipeDTOConversion() async throws {
        // Arrange
        let recipe = Recipe(
            title: "Test Rezept",
            course: .main,
            dietaryType: .vegetarian,
            portions: 4,
            rating: 4.5,
            notes: "Test Notizen",
            tags: ["Test", "Vegetarisch"],
            isFavorite: true,
            difficulty: .medium,
            preparationTime: 30,
            cookingTime: 45
        )

        let step = Step(
            text: "Test Schritt",
            image: "test".data(using: .utf8),
            order: 1,
            ingredients: [
                Ingredient(title: "Test Zutat", amount: 100, unit: .gram),
            ]
        )

        recipe.steps = [step]

        // Act
        let dto = recipe.toDTO()

        // Assert
        #expect(dto.title == "Test Rezept")
        #expect(dto.course == "main")
        #expect(dto.dietaryType == "vegetarian")
        #expect(dto.portions == 4)
        #expect(dto.rating == 4.5)
        #expect(dto.notes == "Test Notizen")
        #expect(dto.tags == ["Test", "Vegetarisch"])
        #expect(dto.isFavorite == true)
        #expect(dto.difficulty == "medium")
        #expect(dto.preparationTime == 30)
        #expect(dto.cookingTime == 45)

        // Steps
        #expect(dto.steps.count == 1)
        let stepDTO = dto.steps[0]
        #expect(stepDTO.text == "Test Schritt")
        #expect(stepDTO.order == 1)
        #expect(stepDTO.image != nil)

        // Ingredients
        #expect(stepDTO.ingredients.count == 1)
        let ingredientDTO = stepDTO.ingredients[0]
        #expect(ingredientDTO.title == "Test Zutat")
        #expect(ingredientDTO.amount == 100)
        #expect(ingredientDTO.unit == "g")
    }

    @Test("Recipe DTO mit minimalen Daten") func recipeDTOMinimal() async throws {
        // Arrange
        let recipe = Recipe(
            title: "Minimal Rezept",
            course: .main,
            dietaryType: .omnivore,
            portions: 1
        )

        // Act
        let dto = recipe.toDTO()

        // Assert
        #expect(dto.title == "Minimal Rezept")
        #expect(dto.course == "main")
        #expect(dto.dietaryType == "omnivore")
        #expect(dto.portions == 1)
        #expect(dto.rating == nil)
        #expect(dto.notes == nil)
        #expect(dto.tags.isEmpty)
        #expect(dto.isFavorite == false)
        #expect(dto.difficulty == nil)
        #expect(dto.preparationTime == nil)
        #expect(dto.cookingTime == nil)
        #expect(dto.steps.isEmpty)
    }
}
