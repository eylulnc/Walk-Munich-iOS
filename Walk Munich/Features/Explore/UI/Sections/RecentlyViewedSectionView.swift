//
//  RecentlyViewedSectionView.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct RecentlyViewedSectionView: View {
    let places: [Place]
    let favoritePlaceIds: Set<String>
    let onPlaceTap: (Place) -> Void
    let onFavoriteTap: (Place) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            Text("section_recently_viewed")
                .font(.title3.bold())
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
