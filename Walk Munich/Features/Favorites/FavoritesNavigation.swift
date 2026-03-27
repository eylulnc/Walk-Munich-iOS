//
//  FavoritesNavigation.swift
//  Walk Munich
//

import SwiftUI

struct FavoritesNavigation: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            FavoritesView(onPlaceTap: { id in path.append(Route.placeDetail(id)) })
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .placeDetail(let id):
                        PlaceDetailView(placeId: id)
                    case .allPlaces:
                        EmptyView()
                    case .tourDetail(_):
                        EmptyView()
                    }
                }
        }
    }
}
