//
//  ExploreViewModel.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import Foundation
import Observation

@Observable
final class ExploreViewModel {

    // MARK: - State

    var isLoading = true
    var error: String?
    var allPlaces: [Place] = []
    var selectedCategory: Category?
    var highlightedPlace: Place?
    var searchQuery = ""
    var searchResults: [SearchResult] = []
    var isSearching = false
    var favoritePlaceIds: Set<String> = []
    var recentlyViewedPlaceIds: [String] = []

    // MARK: - Derived

    var favoritePlaces: [Place] {
        allPlaces.filter { favoritePlaceIds.contains(String($0.id)) }
    }

    var recentlyViewedPlaces: [Place] {
        recentlyViewedPlaceIds.compactMap { id in
            allPlaces.first { String($0.id) == id }
        }
    }

    // MARK: - Private

    private let service = PlacesService()
    private var searchTask: Task<Void, Never>?

    private let favoritesKey = "favoritePlaceIds"
    private let recentlyViewedKey = "recentlyViewedPlaceIds"

    // MARK: - Init

    init() {
        loadPersistedData()
        Task { await loadPlaces() }
    }

    // MARK: - Data Loading

    @MainActor
    func loadPlaces() async {
        isLoading = true
        error = nil
        do {
            let places = try await service.loadPlaces()
            allPlaces = places
            highlightedPlace = places.randomElement()
            isLoading = false
        } catch {
            self.error = error.localizedDescription
            isLoading = false
        }
    }

    // MARK: - Search

    func updateSearch(_ query: String) {
        searchQuery = query
        searchTask?.cancel()

        let trimmed = query.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {
            isSearching = false
            searchResults = []
            return
        }

        isSearching = true
        searchTask = Task { @MainActor [weak self] in
            try? await Task.sleep(for: .milliseconds(450))
            guard !Task.isCancelled, let self else { return }
            self.performSearch(query: trimmed)
        }
    }

    @MainActor
    private func performSearch(query: String) {
        let normalized = normalize(query)
        let results = allPlaces
            .compactMap { place -> (Place, Int)? in
                let name = normalize(place.name)
                let categoryLabel = place.category.displayName
                if name.hasPrefix(normalized) {
                    return (place, 0)
                } else if name.contains(normalized) {
                    return (place, 1)
                } else if categoryLabel.contains(normalized) {
                    return (place, 2)
                }
                return nil
            }
            .sorted {
                if $0.1 != $1.1 { return $0.1 < $1.1 }
                return $0.0.name.count < $1.0.name.count
            }
            .map { SearchResult(place: $0.0, category: $0.0.category) }

        searchResults = results
        isSearching = false
    }

    private func normalize(_ text: String) -> String {
        text.lowercased()
            .replacingOccurrences(of: "ä", with: "ae")
            .replacingOccurrences(of: "ö", with: "oe")
            .replacingOccurrences(of: "ü", with: "ue")
            .replacingOccurrences(of: "ß", with: "ss")
    }

    // MARK: - Favorites

    func toggleFavorite(_ placeId: Int64) {
        let key = String(placeId)
        if favoritePlaceIds.contains(key) {
            favoritePlaceIds.remove(key)
        } else {
            favoritePlaceIds.insert(key)
        }
        UserDefaults.standard.set(Array(favoritePlaceIds), forKey: favoritesKey)
    }

    func isFavorite(_ placeId: Int64) -> Bool {
        favoritePlaceIds.contains(String(placeId))
    }

    // MARK: - Recently Viewed

    func markRecentlyViewed(_ placeId: Int64) {
        let key = String(placeId)
        var ids = recentlyViewedPlaceIds.filter { $0 != key }
        ids.insert(key, at: 0)
        recentlyViewedPlaceIds = Array(ids.prefix(6))
        UserDefaults.standard.set(recentlyViewedPlaceIds, forKey: recentlyViewedKey)
    }

    // MARK: - Persistence

    private func loadPersistedData() {
        let defaults = UserDefaults.standard
        favoritePlaceIds = Set(defaults.stringArray(forKey: favoritesKey) ?? [])
        recentlyViewedPlaceIds = defaults.stringArray(forKey: recentlyViewedKey) ?? []
    }
}

// MARK: - Category helpers

private extension Category {
    var displayName: String {
        switch self {
        case .landmark: return "landmark"
        case .museum: return "museum"
        case .viewpoint: return "viewpoint"
        case .coffee: return "coffee"
        case .food: return "food"
        }
    }
}
