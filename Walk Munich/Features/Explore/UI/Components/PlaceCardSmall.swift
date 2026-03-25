//
//  PlaceCardSmall.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct PlaceCardSmall: View {
    let place: Place
    let isFavorite: Bool
    let onFavoriteTap: () -> Void
    var onTap: () -> Void = {}

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    ZStack(alignment: .bottomLeading) {
                        placeImage
                            .frame(height: 120)
                            .clipped()

                        LinearGradient(
                            colors: [.clear, .black.opacity(0.55)],
                            startPoint: .center,
                            endPoint: .bottom
                        )
                    }

                    favoriteButton
                        .padding(Spacing.small)
                }

                VStack(alignment: .leading, spacing: Spacing.extraSmall) {
                    Text(place.name)
                        .font(.subheadline.bold())
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .fixedSize(horizontal: false, vertical: true)

                    Label(place.category.ui.title, systemImage: place.category.ui.systemImageName)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                .padding(Spacing.small)
            }
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
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
                // Once real place images are added to assets, PlaceholderImageView
                // will no longer be shown. hero_munich kept below for reference:
                // Image("hero_munich").resizable().aspectRatio(contentMode: .fill)
            }
        }
    }

    private var favoriteButton: some View {
        Button(action: onFavoriteTap) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.callout)
                .foregroundStyle(isFavorite ? Color.red : Color.white)
                .padding(Spacing.small - 2)
                .background(Color.black.opacity(0.35))
                .clipShape(Circle())
        }
    }
}
