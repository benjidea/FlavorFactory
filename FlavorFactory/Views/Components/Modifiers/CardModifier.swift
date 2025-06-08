import SwiftUI

/// A view modifier that applies card styling to any view
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(Spacing.size3)
            .background(Color.secondary.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    /// Applies card styling to the view
    func card() -> some View {
        modifier(CardModifier())
    }
}

#Preview {
    VStack(spacing: Spacing.size3) {
        FFText("Simple Card Content")
            .card()

        VStack(alignment: .leading, spacing: Spacing.size2) {
            FFText("Card with Header").font(.headline)
            FFText("Some content here")
        }
        .card()
    }
    .padding()
}
