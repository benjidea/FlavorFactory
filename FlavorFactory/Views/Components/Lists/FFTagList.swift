import SwiftUI

struct FFTagList: View {
    let tags: [String]
    var layout: LayoutStyle = .flow

    enum LayoutStyle {
        case flow
        case scroll(horizontalInset: CGFloat = Spacing.size2)
    }

    var body: some View {
        switch layout {
        case .flow:
            TagWrapLayout(spacing: Spacing.size2) {
                ForEach(tags, id: \.self) { tag in
                    FFTag(text: tag)
                }
            }
            .padding(.vertical, Spacing.size1)
        case let .scroll(horizontalInset):
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Spacing.size2) {
                    Spacer(minLength: horizontalInset)
                    ForEach(tags, id: \.self) { tag in
                        FFTag(text: tag)
                    }
                    Spacer(minLength: horizontalInset)
                }
                .padding(.vertical, Spacing.size1)
            }
        }
    }
}

struct TagWrapLayout: Layout {
    var spacing: CGFloat = Spacing.size2
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) -> CGSize {
        var width: CGFloat = 0
        var height: CGFloat = 0
        var rowHeight: CGFloat = 0
        let maxWidth = proposal.width ?? .infinity

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if width + size.width > maxWidth {
                width = 0
                height += rowHeight + spacing
                rowHeight = 0
            }
            rowHeight = max(rowHeight, size.height)
            width += size.width + spacing
        }
        return CGSize(width: maxWidth, height: height + rowHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal _: ProposedViewSize, subviews: Subviews, cache _: inout ()) {
        var x: CGFloat = bounds.minX
        var y: CGFloat = bounds.minY
        var rowHeight: CGFloat = 0
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX {
                x = bounds.minX
                y += rowHeight + spacing
                rowHeight = 0
            }
            subview.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(width: size.width, height: size.height))
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: Spacing.size3) {
        Text("Flow Layout (Wrapping):")
        FFTagList(tags: ["Pasta", "Italienisch", "Schnell", "Vegetarisch", "Low Carb", "Vegan", "Glutenfrei"], layout: .flow)
        Text("Scroll Layout (Horizontal, default Inset):")
        FFTagList(tags: ["Pasta", "Italienisch", "Schnell", "Vegetarisch", "Low Carb", "Vegan", "Glutenfrei"], layout: .scroll())
        Text("Scroll Layout (Horizontal, large Inset):")
        FFTagList(tags: ["Pasta", "Italienisch", "Schnell", "Vegetarisch", "Low Carb", "Vegan", "Glutenfrei"], layout: .scroll(horizontalInset: Spacing.size4))
    }
    .padding(Spacing.size3)
}
