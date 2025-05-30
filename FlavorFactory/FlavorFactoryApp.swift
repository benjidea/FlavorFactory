//
//  FlavorFactoryApp.swift
//  FlavorFactory
//
//  Created by Benedikt Hruschka on 30.05.25.
//

import SwiftData
import SwiftUI

@main
struct FlavorFactoryApp: App {
    let modelContainer: ModelContainer

    init() {
        do {
            // Configure SwiftData with CloudKit
            let schema = Schema([
                Recipe.self,
                Step.self,
                Ingredient.self,
            ])

            let modelConfiguration = ModelConfiguration(
                schema: schema,
                cloudKitDatabase: .automatic
            )

            modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
