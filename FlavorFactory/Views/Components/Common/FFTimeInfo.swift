import SwiftUI

struct FFTimeInfo: View {
    let title: String
    let time: Int
    var body: some View {
        VStack {
            FFText(title, style: .caption)
                .foregroundStyle(.secondary)
            FFText("\(time) Min")
                .font(.headline)
        }
    }
}

#Preview {
    FFTimeInfo(title: "Zubereitung", time: 15)
    FFTimeInfo(title: "Kochzeit", time: 20)
    FFTimeInfo(title: "Gesamt", time: 35)
}
