//
//  ExploreNavigation.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct ExploreNavigation: View {
    @Binding var selectedTab: AppTab
    @State private var viewModel = ExploreViewModel()
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ExploreView(
                viewModel: viewModel,
                path: $path,
                onSeeAllFavorites: { selectedTab = .favorites }
            )
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .placeDetail(let id):
                    PlaceDetailView(placeId: id)
                case .allPlaces:
                    AllPlacesView(viewModel: viewModel, path: $path)
                }
            }
        }
    }
}
