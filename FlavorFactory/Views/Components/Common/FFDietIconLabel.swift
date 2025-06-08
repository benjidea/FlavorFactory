import SwiftUI

/// A view that displays an icon and label representing the diet type of a recipe
struct FFDietIconLabel: View {
    let diet: Diet

    var body: some View {
        FFIconLabel(systemImage: iconName, text: diet.rawValue)
    }

    private var iconName: String {
        switch diet {
        case .beef:
            // TODO: Replace with appropriate SF Symbol when available
            return "questionmark.circle"
        case .fish:
            return "fish"
        case .lamb:
            // TODO: Replace with appropriate SF Symbol when available
            return "questionmark.circle"
        case .pork:
            // TODO: Replace with appropriate SF Symbol when available
            return "questionmark.circle"
        case .poultry:
            // TODO: Replace with appropriate SF Symbol when available
            return "questionmark.circle"
        case .seafood:
            // TODO: Replace with appropriate SF Symbol when available
            return "questionmark.circle"
        case .vegan, .vegetarian:
            return "leaf"
        case .other:
            return "questionmark.circle"
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ForEach(Diet.allCases, id: \.self) { diet in
            HStack {
                FFDietIconLabel(diet: diet)
            }
        }
    }
    .padding()
}
