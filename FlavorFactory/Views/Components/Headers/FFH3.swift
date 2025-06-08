import SwiftUI

struct FFH3: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(.title3, design: .rounded, weight: .bold))
            .minimumScaleFactor(0.7)
            .lineLimit(2)
    }
}

#Preview {
    FFH3(text: "Pasta Carbonara mit extra langem Namen für den Test")
        .padding(Spacing.size3)
}
