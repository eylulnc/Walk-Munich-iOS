//
//  AllPlacesView.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 25.03.2026.
//

import SwiftUI

struct AllPlacesView: View {
    @Bindable var viewModel: ExploreViewModel
    @Binding var path: NavigationPath

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack(spacing: 0) {
            CategoryChipsView(selectedCategory: $viewModel.selectedCategory)
                .padding(.vertical, Spacing.small)

            ScrollView {
                LazyVGrid(columns: columns, spacing: Spacing.medium) {
                    ForEach(filteredPlaces) { place in
                        PlaceCardSmall(
                            place: place,
                            isFavorite: viewModel.isFavorite(place.id),
                            onFavoriteTap: { viewModel.toggleFavorite(place.id) },
                            onTap: {
                                viewModel.markRecentlyViewed(place.id)
                                path.append(Route.placeDetail(place.id))
                            }
                        )
                    }
                }
                .padding(Spacing.medium)
            }
        }
        .navigationTitle("Explore Munich")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var filteredPlaces: [Place] {
        guard let category = viewModel.selectedCategory else {
            return viewModel.allPlaces
        }
        return viewModel.allPlaces.filter { $0.category == category }
    }
}
