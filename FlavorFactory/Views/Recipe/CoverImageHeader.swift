//
//  CoverImageHeader.swift
//  FlavorFactory
//
//  Created by Benedikt Hruschka on 07.06.25.
//

import SwiftUI

struct CoverImageHeader: View {
    let recipe: Recipe

    // MARK: - Layout Constants

    private let imageHeight: CGFloat = 280
    private let gradientEnd: CGFloat = 0.55
    private let gradientColor = Color(.sRGB, red: 0.12, green: 0.12, blue: 0.16, opacity: 0.75)
    private let textPaddingHorizontal: CGFloat = Spacing.md
    private let textPaddingBottom: CGFloat = Spacing.lg
    private let textShadowRadius: CGFloat = Spacing.xs
    private let iconSpacing: CGFloat = Spacing.md
    private let textSpacing: CGFloat = Spacing.sm

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            image
            gradient
            text
        }
        .frame(maxWidth: .infinity, maxHeight: imageHeight)
        .ignoresSafeArea(edges: .top)
    }

    @ViewBuilder
    private var image: some View {
        if let imageData = recipe.coverImage, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: imageHeight)
                .clipped()
        } else {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(maxWidth: .infinity, maxHeight: imageHeight)
        }
    }

    private var gradient: some View {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: .clear, location: 0.0),
                .init(color: .clear, location: gradientEnd),
                .init(color: gradientColor, location: 1.0),
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .frame(maxWidth: .infinity, maxHeight: imageHeight)
    }

    private var text: some View {
        VStack(alignment: .leading, spacing: textSpacing) {
            Text(recipe.title)
                .font(.largeTitle).bold()
                .foregroundStyle(.white)
                .shadow(radius: textShadowRadius)
            HStack(spacing: iconSpacing) {
                FFIconLabel(systemImage: "fork.knife", text: recipe.course.rawValue)
                    .foregroundStyle(.white)
                FFIconLabel(systemImage: "leaf", text: recipe.dietaryType.rawValue)
                    .foregroundStyle(.white)
                if let difficulty = recipe.difficulty {
                    FFIconLabel(systemImage: "chart.bar", text: difficulty.rawValue)
                        .foregroundStyle(.white)
                }
            }
        }
        .padding(.horizontal, textPaddingHorizontal)
        .padding(.bottom, textPaddingBottom)
    }
}

#Preview {
    CoverImageHeader(recipe: .preview)
}
