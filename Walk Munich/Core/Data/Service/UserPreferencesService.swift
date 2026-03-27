//
//  UserPreferencesService.swift
//  Walk Munich
//

import Foundation
import Observation

@Observable
@MainActor
final class UserPreferencesService {

    static let shared = UserPreferencesService()

    private(set) var favoritePlaceIds: Set<String> = []
    private(set) var recentlyViewedPlaceIds: [String] = []

    private let favoritesKey = "favoritePlaceIds"
    private let recentlyViewedKey = "recentlyViewedPlaceIds"

    private init() {
        let defaults = UserDefaults.standard
        favoritePlaceIds = Set(defaults.stringArray(forKey: favoritesKey) ?? [])
        recentlyViewedPlaceIds = defaults.stringArray(forKey: recentlyViewedKey) ?? []
    }

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

    func addToRecentlyViewed(_ placeId: Int64) {
        let key = String(placeId)
        var ids = recentlyViewedPlaceIds.filter { $0 != key }
        ids.insert(key, at: 0)
        recentlyViewedPlaceIds = Array(ids.prefix(6))
        UserDefaults.standard.set(recentlyViewedPlaceIds, forKey: recentlyViewedKey)
    }
}
