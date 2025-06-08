import SwiftUI

/// Defines the available text styles in the app
enum FFTextStyle {
    case h1
    case h2
    case h3
    case title
    case body
    case caption

    var font: Font {
        switch self {
        case .h1, .title:
            return .system(.largeTitle, design: .rounded, weight: .bold)
        case .h2:
            return .system(.title, design: .rounded, weight: .bold)
        case .h3:
            return .system(.title2, design: .rounded, weight: .semibold)
        case .body:
            return .system(.body, design: .rounded)
        case .caption:
            return .system(.caption, design: .rounded)
        }
    }

    var lineLimit: Int? {
        switch self {
        case .h1, .title:
            return 2
        default:
            return nil
        }
    }

    var minimumScaleFactor: CGFloat {
        switch self {
        case .h1, .title:
            return 0.7
        default:
            return 1.0
        }
    }
}

/// A view modifier that applies text styling
struct TextStyleModifier: ViewModifier {
    let style: FFTextStyle

    func body(content: Content) -> some View {
        content
            .font(style.font)
            .lineLimit(style.lineLimit)
            .minimumScaleFactor(style.minimumScaleFactor)
    }
}
