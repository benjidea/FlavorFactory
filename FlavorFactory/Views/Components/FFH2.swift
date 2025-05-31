import SwiftUI

struct FFH2: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(.title2, design: .rounded, weight: .bold))
            .minimumScaleFactor(0.7)
            .lineLimit(2)
    }
}

#Preview {
    FFH2(text: "Pasta Carbonara mit extra langem Namen für den Test")
        .padding()
}
