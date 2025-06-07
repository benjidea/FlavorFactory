//
//  RecipeDTOTests.swift
//  FlavorFactoryTests
//
//  Created by Benedikt Hruschka on 30.05.25.
//

@testable import FlavorFactory
import Foundation
import SwiftData
import Testing

struct RecipeDTOTests {
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
        let dto = recipe.toDTO(includeImages: true)

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

    @Test("Recipe DTO mit Titelbild") func recipeDTOWithCoverImage() async throws {
        // Arrange
        guard let url = Bundle(for: TestBundleClass.self).url(forResource: "TestImage", withExtension: "jpg"),
              let imageData = try? Data(contentsOf: url)
        else {
            #expect(Bool(false), "TestImage.jpg konnte nicht geladen werden")
            return
        }
        let recipe = Recipe(
            title: "Rezept mit Bild",
            course: .main,
            dietaryType: .omnivore,
            portions: 2,
            coverImage: imageData
        )
        // Act
        let dto = recipe.toDTO(includeImages: true)
        // Assert
        #expect(dto.coverImage != nil)
        #expect(Data(base64Encoded: dto.coverImage!) == imageData)

        let container = try! ModelContainer(for: Recipe.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = ModelContext(container)
        let model = dto.toModel(context: context)
        #expect(model.coverImage == imageData)
    }
}
