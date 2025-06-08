import SwiftUI

private extension View {
    /// Applies a predefined text style to the view
    func textStyle(_ style: FFTextStyle) -> some View {
        modifier(TextStyleModifier(style: style))
    }
}

#Preview {
    FFTitle("Pasta Carbonara mit extra langem Namen für den Test")
        .padding(Spacing.size3)

    FFH1("Pasta Carbonara mit extra langem Namen für den Test")
        .padding(Spacing.size3)

    FFH2("Pasta Carbonara mit extra langem Namen für den Test")
        .padding(Spacing.size3)

    FFH3("Pasta Carbonara mit extra langem Namen für den Test")
        .padding(Spacing.size3)

    FFSectionHeader(text: "Zubereitung")
        .padding(Spacing.size3)

    FFText("Pasta Carbonara mit extra langem Namen für den Test")
        .padding(Spacing.size3)

    FFText("Pasta Carbonara mit extra langem Namen für den Test", style: .caption)
}

struct FFTitle: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .textStyle(.title)
    }
}

struct FFH1: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .textStyle(.h1)
    }
}

struct FFH2: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .textStyle(.h2)
    }
}

struct FFH3: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .textStyle(.h3)
    }
}

struct FFSectionHeader: View {
    let text: String

    var body: some View {
        Text(text)
            .textStyle(.h3)
            .padding(.bottom, Spacing.size1)
    }
}

struct FFText: View {
    let text: String
    let style: Style

    init(_ text: String, style: Style = .body) {
        self.text = text
        self.style = style
    }

    var body: some View {
        switch style {
        case .body:
            Text(text)
                .textStyle(.body)
        case .caption:
            Text(text)
                .textStyle(.caption)
        }
    }

    enum Style {
        case body
        case caption
    }
}
