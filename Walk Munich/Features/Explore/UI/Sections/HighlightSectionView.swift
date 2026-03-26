//
//  HighlightSectionView.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct HighlightSectionView: View {
    let place: Place
    let isFavorite: Bool
    let onFavoriteTap: () -> Void
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            Text("Highlight of the Day")
                .font(.title3.bold())
                .padding(.horizontal, Spacing.medium)

            Button(action: onTap) {
                ZStack(alignment: .topTrailing) {
                    ZStack(alignment: .bottomLeading) {
                        placeImage
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 16))

                        LinearGradient(
                            colors: [.clear, .black.opacity(0.7)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                        VStack(alignment: .leading, spacing: Spacing.extraSmall) {
                            if let story = place.story {
                                Text(story.mainTitle)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                            Text(place.name)
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                        }
                        .padding(Spacing.medium)
                    }

                    Button(action: onFavoriteTap) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .font(.callout)
                            .foregroundStyle(isFavorite ? .red : .white)
                            .padding(Spacing.small)
                            .background(Color.black.opacity(0.35))
                            .clipShape(Circle())
                    }
                    .padding(Spacing.small)
                }
            }
            .buttonStyle(.plain)
            .padding(.horizontal, Spacing.medium)
        }
    }

    private var placeImage: some View {
        Group {
            if UIImage(named: place.imageUrl) != nil {
                Image(place.imageUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                PlaceholderImageView()
            }
        }
    }
}
