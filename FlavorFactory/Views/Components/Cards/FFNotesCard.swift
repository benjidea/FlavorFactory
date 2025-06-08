import SwiftUI

struct FFNotesCard: View {
    let notes: String

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.size2) {
            FFSectionHeader(text: "Notizen")
            Text(notes)
                .foregroundStyle(.secondary)
        }
        .card()
    }
}

#Preview {
    FFNotesCard(notes: "Das ist ein Beispiel für Notizen. Sie können beliebig lang sein und werden optisch abgesetzt dargestellt.")
        .padding(Spacing.size3)
}
