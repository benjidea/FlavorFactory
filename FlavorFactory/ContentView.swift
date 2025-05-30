//
//  ContentView.swift
//  FlavorFactory
//
//  Created by Benedikt Hruschka on 30.05.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "fork.knife")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, FlavorFactory!")
        }
    }
}

#Preview {
    ContentView()
}
