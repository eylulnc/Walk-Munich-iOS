//
//  TourDetailViewModel.swift
//  Walk Munich
//

import Foundation
import Observation

@Observable
@MainActor
final class TourDetailViewModel {
    private(set) var tourDetail: TourDetail?
    private(set) var isLoading = true
    private(set) var error: String?

    private let tourId: Int64
    private let service = ToursService()

    init(tourId: Int64) {
        self.tourId = tourId
        Task { await loadTourDetail() }
    }

    func loadTourDetail() async {
        isLoading = true
        error = nil
        do {
            tourDetail = try await service.loadTourDetail(id: tourId)
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
