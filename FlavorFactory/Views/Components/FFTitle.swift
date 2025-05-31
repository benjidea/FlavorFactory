import SwiftUI

struct FFTitle: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(.largeTitle, design: .rounded, weight: .bold))
            .minimumScaleFactor(0.7)
            .lineLimit(2)
    }
}

#Preview {
    FFTitle(text: "Pasta Carbonara mit extra langem Namen für den Test")
        .padding()
}
