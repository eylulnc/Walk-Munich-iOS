//
//  MapNavigation.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct MapNavigation: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            MapView { placeId in
                path.append(Route.placeDetail(placeId))
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .placeDetail(let id):
                    PlaceDetailView(placeId: id)
                case .allPlaces, .tourDetail:
                    EmptyView()
                }
            }
        }
    }
}
