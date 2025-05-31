import SwiftUI

struct FFTag: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(Color.secondary.opacity(0.15))
            .clipShape(Capsule())
    }
}

#Preview {
    FFTag(text: "Pasta")
    FFTag(text: "Italienisch")
    FFTag(text: "Schnell")
}
