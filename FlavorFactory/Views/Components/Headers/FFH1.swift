import SwiftUI

struct FFH1: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(.largeTitle, design: .rounded, weight: .bold))
            .minimumScaleFactor(0.7)
            .lineLimit(2)
    }
}

#Preview {
    FFH1(text: "Pasta Carbonara mit extra langem Namen für den Test")
        .padding(Spacing.size3)
}
