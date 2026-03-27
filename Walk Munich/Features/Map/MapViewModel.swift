//
//  MapViewModel.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import Foundation
import Observation

@Observable
@MainActor
final class MapViewModel {
    var places: [Place] = []
    var isLoading = false
    var error: String?

    private let service = PlacesService()

    init() {
        Task { await loadPlaces() }
    }

    func loadPlaces() async {
        isLoading = true
        error = nil
        do {
            places = try await service.loadPlaces()
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
