import SwiftUI

struct FFTagList: View {
    let tags: [String]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    FFTag(text: tag)
                }
            }
            .padding(.vertical, 2)
        }
    }
}

#Preview {
    FFTagList(tags: ["Pasta", "Italienisch", "Schnell"])
        .padding(Spacing.md)
}
