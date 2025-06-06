import SwiftUI

struct FFTag: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.xs)
            .background(Color.secondary.opacity(0.15))
            .clipShape(Capsule())
    }
}

#Preview {
    FFTag(text: "Pasta")
    FFTag(text: "Italienisch")
    FFTag(text: "Schnell")
}
