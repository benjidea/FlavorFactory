import SwiftUI

struct FFTimeInfo: View {
    let title: String
    let time: Int
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("\(time) Min")
                .font(.headline)
        }
    }
}

#Preview {
    FFTimeInfo(title: "Zubereitung", time: 15)
    FFTimeInfo(title: "Kochzeit", time: 20)
    FFTimeInfo(title: "Gesamt", time: 35)
}
