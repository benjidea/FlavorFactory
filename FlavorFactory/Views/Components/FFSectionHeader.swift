import SwiftUI

struct FFSectionHeader: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.title3)
            .bold()
            .padding(.bottom, 2)
    }
}

#Preview {
    FFSectionHeader(text: "Zubereitung")
        .padding()
}
