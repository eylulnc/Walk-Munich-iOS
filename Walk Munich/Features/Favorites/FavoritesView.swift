//
//  FavoritesView.swift
//  Walk Munich
//

import SwiftUI

struct FavoritesView: View {
    @State private var viewModel = FavoritesViewModel()
    let onPlaceTap: (Int64) -> Void

    var body: some View {
        Group {
            if viewModel.isLoading && viewModel.allPlaces.isEmpty {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.favoritePlaces.isEmpty {
                emptyState
            } else if viewModel.isGridView {
                gridView
            } else {
                listView
            }
        }
        .navigationTitle("favorites_title")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: viewModel.toggleLayout) {
                    Image(systemName: viewModel.isGridView ? "list.bullet" : "square.grid.2x2")
                }
            }
        }
    }

    private var gridView: some View {
        ScrollView {
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: Spacing.medium
            ) {
                ForEach(viewModel.favoritePlaces) { place in
                    PlaceCardSmall(
                        place: place,
                        isFavorite: true,
                        onFavoriteTap: { viewModel.toggleFavorite(place.id) },
                        onTap: { onPlaceTap(place.id) }
                    )
                }
            }
            .padding(Spacing.medium)
        }
    }

    private var listView: some View {
        ScrollView {
            LazyVStack(spacing: Spacing.medium) {
                ForEach(viewModel.favoritePlaces) { place in
                    PlaceCardLarge(
                        place: place,
                        isFavorite: true,
                        onFavoriteTap: { viewModel.toggleFavorite(place.id) },
                        onTap: { onPlaceTap(place.id) }
                    )
                }
            }
            .padding(Spacing.medium)
        }
    }

    private var emptyState: some View {
        VStack(spacing: Spacing.medium) {
            Image(systemName: "heart")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            Text("favorites_empty_title")
                .font(.headline)
                .foregroundStyle(.secondary)
            Text("favorites_empty_subtitle")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(Spacing.large)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
