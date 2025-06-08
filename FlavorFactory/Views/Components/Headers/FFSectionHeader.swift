import SwiftUI

struct FFSectionHeader: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.title3)
            .bold()
            .padding(.bottom, Spacing.xs)
    }
}

#Preview {
    FFSectionHeader(text: "Zubereitung")
        .padding(Spacing.md)
}
