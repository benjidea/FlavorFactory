import SwiftData
import SwiftUI

struct RecipeListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Recipe.title) private var recipes: [Recipe]
    @Binding var selection: Recipe?
    @State private var showImporter = false
    @State private var importError: Error?
    @State private var recipeToDelete: Recipe?
    @State private var showDeleteDialog = false

    var body: some View {
        List(selection: $selection) {
            ForEach(recipes) { recipe in
                NavigationLink(value: recipe) {
                    RecipeRowView(recipe: recipe)
                }
                .swipeActions {
                    // SwiftUI quirk: If you use `role: .destructive` in swipeActions, the row is immediately removed from the list
                    // before the confirmation dialog appears, causing a visual flicker if the user cancels.
                    // By using a regular Button with `.tint(.red)` instead, the row stays visible until the user confirms deletion.
                    Button {
                        recipeToDelete = recipe
                        showDeleteDialog = true
                    } label: {
                        Label("Löschen", systemImage: "trash")
                    }
                    .tint(.red)
                }
            }
        }
        .navigationTitle("Rezepte")
        .toolbar {
            ToolbarItem {
                Menu {
                    Button(action: addRecipe) {
                        Label("Neues Rezept anlegen", systemImage: "plus")
                    }
                    Button {
                        showImporter = true
                    } label: {
                        Label("Rezept importieren", systemImage: "square.and.arrow.down")
                    }
                } label: {
                    Label("Aktionen", systemImage: "plus")
                }
            }
        }
        .fileImporter(
            isPresented: $showImporter,
            allowedContentTypes: [.json],
            allowsMultipleSelection: false
        ) { result in
            switch result {
            case let .success(urls):
                guard let url = urls.first else { return }
                if url.startAccessingSecurityScopedResource() {
                    defer { url.stopAccessingSecurityScopedResource() }
                    do {
                        let data = try Data(contentsOf: url)
                        let decoder = JSONDecoder()
                        let dto = try decoder.decode(RecipeDTO.self, from: data)
                        let recipe = dto.toModel(context: modelContext)
                        modelContext.insert(recipe)
                        selection = recipe
                    } catch {
                        importError = error
                    }
                } else {
                    importError = NSError(domain: "Import", code: 1, userInfo: [NSLocalizedDescriptionKey: "Kein Zugriff auf die Datei."])
                }
            case let .failure(error):
                importError = error
            }
        }
        .alert("Import fehlgeschlagen", isPresented: Binding(get: { importError != nil }, set: { _ in importError = nil })) {
            Button("OK", role: .cancel) {}
        } message: {
            FFText(importError?.localizedDescription ?? "Unbekannter Fehler")
        }
        .confirmationDialog(
            "Rezept löschen?",
            isPresented: $showDeleteDialog,
            titleVisibility: .visible
        ) {
            Button("Löschen", role: .destructive) {
                if let recipe = recipeToDelete {
                    deleteRecipe(recipe)
                }
            }
            Button("Abbrechen", role: .cancel) {}
        } message: {
            if let recipe = recipeToDelete {
                FFText("Möchtest du das Rezept '\(recipe.title)' wirklich löschen?")
            }
        }
    }

    private func addRecipe() {
        // TODO:
    }

    private func deleteRecipe(_ recipe: Recipe) {
        withAnimation {
            modelContext.delete(recipe)
            if selection == recipe {
                selection = nil
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecipeListView(selection: .constant(nil))
    }
    .modelContainer(PreviewData.shared.modelContainer)
}
