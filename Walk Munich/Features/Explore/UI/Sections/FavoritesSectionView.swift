//
//  FavoritesSectionView.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct FavoritesSectionView: View {
    let places: [Place]
    let favoritePlaceIds: Set<String>
    let onPlaceTap: (Place) -> Void
    let onFavoriteTap: (Place) -> Void
    let onSeeAll: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            SectionHeader("section_your_favorites", onSeeAll: onSeeAll)
                .padding(.horizontal, Spacing.medium)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Spacing.medium) {
                    ForEach(places) { place in
                        PlaceCard(
                            place: place,
                            isFavorite: favoritePlaceIds.contains(String(place.id)),
                            onFavoriteTap: { onFavoriteTap(place) },
                            onTap: { onPlaceTap(place) }
                        )
                    }
                }
                .padding(.horizontal, Spacing.medium)
            }
        }
    }
}
