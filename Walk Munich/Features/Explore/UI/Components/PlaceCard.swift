//
//  PlaceCard.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct PlaceCard: View {
    let place: Place
    let isFavorite: Bool
    let onFavoriteTap: () -> Void
    var onTap: () -> Void = {}

    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .bottomLeading) {
                placeImage
                    .frame(width: 200, height: 260)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                LinearGradient(
                    colors: [.clear, .black.opacity(0.65)],
                    startPoint: .center,
                    endPoint: .bottom
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))

                VStack(alignment: .leading, spacing: Spacing.extraSmall) {
                    categoryBadge
                    Text(place.name)
                        .font(.subheadline.bold())
                        .foregroundStyle(.white)
                        .lineLimit(2)
                }
                .padding(Spacing.small + 4)

                VStack {
                    HStack {
                        Spacer()
                        favoriteButton
                            .padding(Spacing.small)
                    }
                    Spacer()
                }
            }
            .frame(width: 200, height: 260)
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

    private var categoryBadge: some View {
        Label(place.category.ui.title, systemImage: place.category.ui.systemImageName)
            .font(.caption2.weight(.medium))
            .foregroundStyle(.white)
            .padding(.horizontal, Spacing.small)
            .padding(.vertical, Spacing.extraSmall)
            .background(WalkMunichTheme.primary.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private var favoriteButton: some View {
        Button(action: onFavoriteTap) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.callout)
                .foregroundStyle(isFavorite ? Color.red : Color.white)
                .padding(Spacing.small)
                .background(Color.black.opacity(0.35))
                .clipShape(Circle())
        }
    }
}
