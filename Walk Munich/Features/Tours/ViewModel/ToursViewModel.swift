//
//  ToursViewModel.swift
//  Walk Munich
//

import Foundation
import Observation

@Observable
@MainActor
final class ToursViewModel {
    private(set) var tours: [TourSummary] = []
    private(set) var isLoading = true
    private(set) var error: String?

    private let service = ToursService()

    init() {
        Task { await loadTours() }
    }

    func loadTours() async {
        isLoading = true
        error = nil
        do {
            tours = try await service.loadTours()
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
