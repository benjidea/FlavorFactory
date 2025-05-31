import SwiftData
import SwiftUI

struct RecipeListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Recipe.title) private var recipes: [Recipe]
    @Binding var selection: Recipe?

    var body: some View {
        List(recipes, selection: $selection) { recipe in
            NavigationLink(value: recipe) {
                RecipeRowView(recipe: recipe)
            }
        }
        .navigationTitle("Rezepte")
        .toolbar {
            ToolbarItem {
                Button(action: addRecipe) {
                    Label("Rezept hinzufügen", systemImage: "plus")
                }
            }
        }
    }

    private func addRecipe() {
        withAnimation {
            let newRecipe = Recipe(
                title: "Neues Rezept",
                course: .main,
                dietaryType: .omnivore,
                portions: 4
            )
            modelContext.insert(newRecipe)
            selection = newRecipe
        }
    }
}

#Preview {
    NavigationStack {
        RecipeListView(selection: .constant(nil))
    }
    .modelContainer(PreviewData.shared.modelContainer)
}
