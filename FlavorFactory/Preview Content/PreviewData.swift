import Foundation
import SwiftData
#if canImport(UIKit)
    import UIKit
#endif

#if DEBUG
    @MainActor
    class PreviewData {
        static let shared = PreviewData()

        let modelContainer: ModelContainer

        init() {
            do {
                let schema = Schema([
                    Recipe.self,
                    Step.self,
                    Ingredient.self,
                ])

                let modelConfiguration = ModelConfiguration(
                    schema: schema,
                    isStoredInMemoryOnly: true
                )

                modelContainer = try ModelContainer(
                    for: schema,
                    configurations: [modelConfiguration]
                )

                // Insert sample data for previews
                insertSampleData()
            } catch {
                fatalError("Could not create preview container: \(error)")
            }
        }

        private func previewImage(named name: String) -> Data? {
            #if canImport(UIKit)
                if let data = UIImage(named: name)?.pngData() {
                    return data
                } else {
                    // Dummy 1x1 PNG (transparent)
                    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1))
                    let img = renderer.image { ctx in
                        UIColor.clear.setFill()
                        ctx.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
                    }
                    return img.pngData()
                }
            #else
                return nil
            #endif
        }

        private func insertSampleData() {
            let modelContext = modelContainer.mainContext

            // Pasta Carbonara
            let carbonara = Recipe(
                title: "Pasta Carbonara",
                course: .main,
                dietaryType: .omnivore,
                portions: 4,
                rating: 4.5,
                notes: "Traditionelles italienisches Rezept",
                tags: ["Pasta", "Italienisch", "Schnell"],
                isFavorite: true,
                difficulty: .medium,
                preparationTime: 15,
                cookingTime: 20
            )

            let step1 = Step(
                text: "Pasta in Salzwasser kochen",
                image: previewImage(named: "step_1"),
                order: 1,
                ingredients: [
                    Ingredient(title: "Spaghetti", amount: 500, unit: .gram),
                    Ingredient(title: "Salz", amount: 1, unit: .tablespoon),
                ]
            )

            let step2 = Step(
                text: "Speck in einer Pfanne knusprig braten",
                image: previewImage(named: "step_2"),
                order: 2,
                ingredients: [
                    Ingredient(title: "Speck", amount: 200, unit: .gram),
                ]
            )

            let step3 = Step(
                text: "Eier und Käse verrühren",
                image: previewImage(named: "step_3"),
                order: 3,
                ingredients: [
                    Ingredient(title: "Eier", amount: 4, unit: .piece),
                    Ingredient(title: "Parmesan", amount: 100, unit: .gram),
                    Ingredient(title: "Pfeffer", amount: 1, unit: .teaspoon),
                ]
            )

            carbonara.steps = [step1, step2, step3]
            modelContext.insert(carbonara)

            // Vegane Buddha Bowl
            let buddhaBowl = Recipe(
                title: "Vegane Buddha Bowl",
                course: .main,
                dietaryType: .vegan,
                portions: 2,
                rating: 4.0,
                notes: "Gesund und nahrhaft",
                tags: ["Vegan", "Gesund", "Bowl"],
                isFavorite: false,
                difficulty: .easy,
                preparationTime: 20,
                cookingTime: 30
            )

            let step4 = Step(
                text: "Quinoa waschen und kochen",
                order: 1,
                ingredients: [
                    Ingredient(title: "Quinoa", amount: 200, unit: .gram),
                    Ingredient(title: "Wasser", amount: 400, unit: .milliliter),
                ]
            )

            let step5 = Step(
                text: "Gemüse schneiden und anbraten",
                order: 2,
                ingredients: [
                    Ingredient(title: "Süßkartoffel", amount: 1, unit: .piece),
                    Ingredient(title: "Brokkoli", amount: 1, unit: .piece),
                    Ingredient(title: "Olivenöl", amount: 2, unit: .tablespoon),
                ]
            )

            buddhaBowl.steps = [step4, step5]
            modelContext.insert(buddhaBowl)

            // Schokoladenkuchen
            let cake = Recipe(
                title: "Schokoladenkuchen",
                course: .dessert,
                dietaryType: .omnivore,
                portions: 8,
                rating: 5.0,
                notes: "Super saftig und schokoladig",
                tags: ["Kuchen", "Dessert", "Schokolade"],
                isFavorite: true,
                difficulty: .medium,
                preparationTime: 30,
                cookingTime: 45
            )

            let step6 = Step(
                text: "Ofen auf 180°C vorheizen",
                order: 1
            )

            let step7 = Step(
                text: "Zutaten vermischen",
                order: 2,
                ingredients: [
                    Ingredient(title: "Mehl", amount: 200, unit: .gram),
                    Ingredient(title: "Zucker", amount: 200, unit: .gram),
                    Ingredient(title: "Kakao", amount: 50, unit: .gram),
                    Ingredient(title: "Butter", amount: 200, unit: .gram),
                ]
            )

            cake.steps = [step6, step7]
            modelContext.insert(cake)
        }
    }

    // MARK: - Preview Helper

    extension Recipe {
        static var preview: Recipe {
            let recipe = Recipe(
                title: "Pasta Carbonara",
                course: .main,
                dietaryType: .omnivore,
                portions: 4,
                rating: 4.5,
                notes: "Traditionelles italienisches Rezept",
                tags: ["Pasta", "Italienisch", "Schnell"],
                isFavorite: true,
                difficulty: .medium,
                preparationTime: 15,
                cookingTime: 20
            )

            let step1 = Step(
                text: "Pasta in Salzwasser kochen",
                image: UIImage(named: "step_1")?.pngData(),
                order: 1,
                ingredients: [
                    Ingredient(title: "Spaghetti", amount: 500, unit: .gram),
                    Ingredient(title: "Salz", amount: 1, unit: .tablespoon, available: true),
                ]
            )

            let step2 = Step(
                text: "Speck in einer Pfanne knusprig braten",
                image: UIImage(named: "step_2")?.pngData(),
                order: 2,
                ingredients: [
                    Ingredient(title: "Speck", amount: 200, unit: .gram),
                ]
            )

            let step3 = Step(
                text: "Eier und Käse verrühren",
                image: UIImage(named: "step_3")?.pngData(),
                order: 3,
                ingredients: [
                    Ingredient(title: "Eier", amount: 4, unit: .piece),
                    Ingredient(title: "Parmesan", amount: 100, unit: .gram),
                    Ingredient(title: "Pfeffer", amount: 1, unit: .teaspoon, available: true),
                    Ingredient(title: "Salz", amount: 1, unit: .tablespoon, available: true),
                ]
            )

            recipe.steps = [step1, step2, step3]
            return recipe
        }
    }
#endif
