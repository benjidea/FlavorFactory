import SwiftData
import SwiftUI

struct RecipeListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Recipe.title) private var recipes: [Recipe]
    @Binding var selection: Recipe?
    @State private var showImporter = false
    @State private var importError: Error?

    var body: some View {
        List(recipes, selection: $selection) { recipe in
            NavigationLink(value: recipe) {
                RecipeRowView(recipe: recipe)
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
            Text(importError?.localizedDescription ?? "Unbekannter Fehler")
        }
    }

    private func addRecipe() {
        // TODO:
    }
}

#Preview {
    NavigationStack {
        RecipeListView(selection: .constant(nil))
    }
    .modelContainer(PreviewData.shared.modelContainer)
}
