//
//  PlaceCardLarge.swift
//  Walk Munich
//

import SwiftUI

struct PlaceCardLarge: View {
    let place: Place
    let isFavorite: Bool
    let onFavoriteTap: () -> Void
    var onTap: () -> Void = {}

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    placeImage
                        .frame(width: 120, height: 100)
                        .clipped()

                    Button(action: onFavoriteTap) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .font(.caption)
                            .foregroundStyle(isFavorite ? .red : .white)
                            .padding(Spacing.small - 2)
                            .background(Color.black.opacity(0.35))
                            .clipShape(Circle())
                    }
                    .padding(Spacing.small)
                }

                VStack(alignment: .leading, spacing: Spacing.extraSmall) {
                    Text(place.name)
                        .font(.subheadline.bold())
                        .foregroundStyle(.primary)
                        .lineLimit(1)

                    Text(place.category.ui.title)
                        .font(.caption)
                        .foregroundStyle(WalkMunichTheme.primary)
                }
                .padding(.horizontal, Spacing.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 100)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color(.systemGray4).opacity(0.5), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
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
