import SwiftUI

struct FFIconLabel: View {
    let systemImage: String
    let text: String
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: systemImage)
                .font(.caption)
            FFText(text, style: .caption)
        }
    }
}

#Preview {
    HStack(spacing: 12) {
        FFIconLabel(systemImage: "fork.knife", text: "Hauptgang")
        FFIconLabel(systemImage: "leaf", text: "Vegan")
        FFIconLabel(systemImage: "chart.bar", text: "medium")
    }
    .padding(Spacing.size3)
}
