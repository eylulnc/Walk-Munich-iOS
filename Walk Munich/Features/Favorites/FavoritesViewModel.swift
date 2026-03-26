//
//  FavoritesViewModel.swift
//  Walk Munich
//

import Foundation
import Observation

@Observable
@MainActor
final class FavoritesViewModel {

    var allPlaces: [Place] = []
    var isGridView = true
    var isLoading = false

    var favoritePlaces: [Place] {
        allPlaces.filter { preferences.favoritePlaceIds.contains(String($0.id)) }
    }

    private let preferences = UserPreferencesService.shared
    private let service = PlacesService()

    init() {
        Task { await loadPlaces() }
    }

    func loadPlaces() async {
        isLoading = true
        do {
            allPlaces = try await service.loadPlaces()
        } catch {}
        isLoading = false
    }

    func toggleFavorite(_ placeId: Int64) {
        preferences.toggleFavorite(placeId)
    }

    func toggleLayout() {
        isGridView.toggle()
    }
}
