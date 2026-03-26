//
//  ExploreView.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct ExploreView: View {
    @Bindable var viewModel: ExploreViewModel
    @Binding var path: NavigationPath
    let onSeeAllFavorites: () -> Void

    var body: some View {
        Group {
            if viewModel.isLoading {
                loadingView
            } else if let error = viewModel.error {
                errorView(message: error)
            } else if !viewModel.searchQuery.isEmpty {
                SearchResultsSection(
                    results: viewModel.searchResults,
                    isSearching: viewModel.isSearching,
                    query: viewModel.searchQuery,
                    favoritePlaceIds: viewModel.favoritePlaceIds,
                    onPlaceTap: navigate(to:),
                    onFavoriteTap: { viewModel.toggleFavorite($0.id) }
                )
            } else {
                mainContent
            }
        }
        .navigationTitle("Walk Munich")
        .navigationBarTitleDisplayMode(.large)
        .searchable(
            text: Binding(
                get: { viewModel.searchQuery },
                set: { viewModel.updateSearch($0) }
            ),
            prompt: "Search places..."
        )
    }

    // MARK: - Main Content

    private var mainContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.large) {

                // Places section (first 5)
                if !viewModel.allPlaces.isEmpty {
                    PlacesSectionView(
                        places: Array(viewModel.allPlaces.prefix(5)),
                        favoritePlaceIds: viewModel.favoritePlaceIds,
                        onPlaceTap: navigate(to:),
                        onFavoriteTap: { viewModel.toggleFavorite($0.id) },
                        onSeeAll: { path.append(Route.allPlaces) }
                    )
                }

                // Highlight of the day
                if let highlighted = viewModel.highlightedPlace {
                    HighlightSectionView(
                        place: highlighted,
                        isFavorite: viewModel.isFavorite(highlighted.id),
                        onFavoriteTap: { viewModel.toggleFavorite(highlighted.id) },
                        onTap: { navigate(to: highlighted) }
                    )
                }

                // Favorites
                if !viewModel.favoritePlaces.isEmpty {
                    FavoritesSectionView(
                        places: Array(viewModel.favoritePlaces.prefix(5)),
                        favoritePlaceIds: viewModel.favoritePlaceIds,
                        onPlaceTap: navigate(to:),
                        onFavoriteTap: { viewModel.toggleFavorite($0.id) },
                        onSeeAll: onSeeAllFavorites
                    )
                }

                // Recently Viewed
                if !viewModel.recentlyViewedPlaces.isEmpty {
                    RecentlyViewedSectionView(
                        places: viewModel.recentlyViewedPlaces,
                        favoritePlaceIds: viewModel.favoritePlaceIds,
                        onPlaceTap: navigate(to:),
                        onFavoriteTap: { viewModel.toggleFavorite($0.id) }
                    )
                }

                Spacer(minLength: Spacing.large)
            }
            .padding(.vertical, Spacing.small)
        }
    }

    // MARK: - Loading & Error

    private var loadingView: some View {
        VStack(spacing: Spacing.medium) {
            ProgressView()
                .scaleEffect(1.2)
            Text("Loading places...")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func errorView(message: String) -> some View {
        VStack(spacing: Spacing.medium) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundStyle(WalkMunichTheme.error)
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Button("Retry") {
                Task { await viewModel.loadPlaces() }
            }
            .buttonStyle(.borderedProminent)
            .tint(WalkMunichTheme.primary)
        }
        .padding(Spacing.large)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Navigation

    private func navigate(to place: Place) {
        viewModel.markRecentlyViewed(place.id)
        path.append(Route.placeDetail(place.id))
    }
}
