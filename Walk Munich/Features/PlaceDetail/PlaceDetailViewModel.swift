//
//  PlaceDetailViewModel.swift
//  Walk Munich
//

import Foundation
import Observation

@Observable
@MainActor
final class PlaceDetailViewModel {

    // MARK: - State

    var isLoading = true
    var error: String?
    var place: Place?

    var isFavorite: Bool { preferences.isFavorite(placeId) }

    // MARK: - Private

    private let placeId: Int64
    private let service = PlacesService()
    private let preferences = UserPreferencesService.shared

    // MARK: - Init

    init(placeId: Int64) {
        self.placeId = placeId
        Task { await loadPlace() }
    }

    // MARK: - Data Loading

    func loadPlace() async {
        isLoading = true
        error = nil
        do {
            let places = try await service.loadPlaces()
            place = places.first { $0.id == placeId }
            if place == nil { error = "Place not found" }
            isLoading = false
            preferences.addToRecentlyViewed(placeId)
        } catch {
            self.error = error.localizedDescription
            isLoading = false
        }
    }

    // MARK: - Favorites

    func toggleFavorite() {
        preferences.toggleFavorite(placeId)
    }
}
