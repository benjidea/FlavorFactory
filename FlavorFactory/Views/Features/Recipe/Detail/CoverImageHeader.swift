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
    private let textPaddingHorizontal: CGFloat = Spacing.size3
    private let textPaddingBottom: CGFloat = Spacing.size4
    private let textShadowRadius: CGFloat = Spacing.size1
    private let iconSpacing: CGFloat = Spacing.size3
    private let textSpacing: CGFloat = Spacing.size2

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
            FFTitle(recipe.title)
                .foregroundStyle(.white)
                .shadow(radius: textShadowRadius)
            HStack(spacing: iconSpacing) {
                FFIconLabel(systemImage: "fork.knife", text: recipe.course.rawValue)
                    .foregroundStyle(.white)
                HStack(spacing: Spacing.size1) {
                    FFDietIconLabel(diet: recipe.diet)
                        .foregroundStyle(.white)
                }
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
