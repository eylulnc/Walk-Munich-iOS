//
//  ExploreNavigation.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct ExploreNavigation: View {
    @State private var viewModel = ExploreViewModel()
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ExploreView(viewModel: viewModel, path: $path)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                        
                    case .placeDetail(let id):
                        // TODO: Replace with PlaceDetailView(placeId: id)
                        if let place = viewModel.allPlaces.first(where: { $0.id == id }) {
                            Text(place.name)
                                .navigationTitle(place.name)
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    case .allPlaces:
                        AllPlacesView(viewModel: viewModel, path: $path)
                    }
                }
        }
    }
}
