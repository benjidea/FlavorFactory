@testable import FlavorFactory
import Foundation
import SwiftData
import Testing

struct IngredientDTOTests {
    @Test("IngredientDTO Mapping") func ingredientDTOMapping() async throws {
        // Arrange
        let ingredient = Ingredient(title: "Salz", amount: 0.5, unit: .tablespoon, available: true)
        // Act
        let dto = ingredient.toDTO()
        // Assert
        #expect(dto.title == "Salz")
        #expect(dto.amount == 0.5)
        #expect(dto.unit == "tbsp")
        #expect(dto.available == true)

        let container = try! ModelContainer(for: Ingredient.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = ModelContext(container)
        let model = dto.toModel(context: context)
        #expect(model.title == "Salz")
        #expect(model.amount == 0.5)
        #expect(model.unit == .tablespoon)
        #expect(model.available == true)
    }
}
