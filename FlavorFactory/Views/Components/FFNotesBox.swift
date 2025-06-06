import SwiftUI

struct FFNotesBox: View {
    let notes: String
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            FFSectionHeader(text: "Notizen")
            Text(notes)
                .foregroundStyle(.secondary)
        }
        .padding(Spacing.md)
        .background(Color.secondary.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    FFNotesBox(notes: "Das ist ein Beispiel für Notizen. Sie können beliebig lang sein und werden optisch abgesetzt dargestellt.")
        .padding(Spacing.md)
}
