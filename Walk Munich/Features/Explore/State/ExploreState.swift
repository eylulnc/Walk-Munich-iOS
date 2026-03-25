//
//  ExploreState.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

struct ExploreState {
    var isLoading: Bool
    var error: String?
    var allPlaces: [Place]
    var selectedCategory: Category?
    var highlightedPlace: Place?
    var searchQuery: String
    var searchResults: [SearchResult]
    var isSearching: Bool
    var favoritePlaceIds: Set<String>
    var recentlyViewedPlaceIds: [String]
}

extension ExploreState {
    static let initial = ExploreState(
        isLoading: true,
        error: nil,
        allPlaces: [],
        selectedCategory: nil,
        highlightedPlace: nil,
        searchQuery: "",
        searchResults: [],
        isSearching: false,
        favoritePlaceIds: [],
        recentlyViewedPlaceIds: []
    )
}
