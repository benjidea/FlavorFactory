@testable import FlavorFactory
import Foundation
import SwiftData
import Testing

struct StepDTOTests {
    @Test("StepDTO Mapping mit Bild und Zutaten") func stepDTOMapping() async throws {
        // Arrange
        let imageData = Data([0xAA, 0xBB, 0xCC])
        let step = Step(
            text: "Schritt 1",
            image: imageData,
            order: 1,
            ingredients: [
                Ingredient(title: "Zutat A", amount: 1.5, unit: .gram),
                Ingredient(title: "Zutat B", amount: 2, unit: .piece),
            ]
        )
        // Act
        let dto = step.toDTO(includeImages: true)
        // Assert
        #expect(dto.text == "Schritt 1")
        #expect(dto.image != nil)
        #expect(Data(base64Encoded: dto.image!) == imageData)
        #expect(dto.order == 1)
        #expect(dto.ingredients.count == 2)

        let container = try! ModelContainer(for: Step.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = ModelContext(container)
        let model = dto.toModel(context: context)
        #expect(model.text == "Schritt 1")
        #expect(model.image == imageData)
        #expect(model.order == 1)
        #expect(model.ingredients?.count == 2)
        #expect(model.ingredients?[0].title == "Zutat A")
        #expect(model.ingredients?[1].title == "Zutat B")
    }
}
