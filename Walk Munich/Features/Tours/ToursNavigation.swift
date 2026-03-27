//
//  ToursNavigation.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//


import SwiftUI

struct ToursNavigation: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ToursView(onTourTap: { id in
                path.append(Route.tourDetail(id))
            })
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .tourDetail(let id):
                    TourDetailView(tourId: id) { placeId in
                        path.append(Route.placeDetail(placeId))
                    }
                case .placeDetail(let id):
                    PlaceDetailView(placeId: id)
                case .allPlaces:
                    EmptyView()
                }
            }
        }
    }
}
