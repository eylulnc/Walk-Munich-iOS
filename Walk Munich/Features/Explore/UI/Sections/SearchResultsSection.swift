//
//  SearchResultsSection.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct SearchResultsSection: View {
    let results: [SearchResult]
    let isSearching: Bool
    let query: String
    let favoritePlaceIds: Set<String>
    let onPlaceTap: (Place) -> Void
    let onFavoriteTap: (Place) -> Void

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        Group {
            if isSearching {
                VStack {
                    Spacer()
                    ProgressView("Searching...")
                        .foregroundStyle(.secondary)
                    Spacer()
                }
            } else if results.isEmpty {
                VStack(spacing: Spacing.medium) {
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                    Text("No results for \"\(query)\"")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
                .padding(.horizontal, Spacing.medium)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: Spacing.medium) {
                        ForEach(results) { result in
                            PlaceCardSmall(
                                place: result.place,
                                isFavorite: favoritePlaceIds.contains(String(result.place.id)),
                                onFavoriteTap: { onFavoriteTap(result.place) },
                                onTap: { onPlaceTap(result.place) }
                            )
                        }
                    }
                    .padding(Spacing.medium)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
