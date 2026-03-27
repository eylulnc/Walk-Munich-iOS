//
//  ToursService.swift
//  Walk Munich
//

import Foundation

enum ToursError: LocalizedError {
    case fileNotFound(String)
    case decodingFailed(Error)

    var errorDescription: String? {
        switch self {
        case .fileNotFound(let name): return "Tour data file '\(name)' not found."
        case .decodingFailed(let error): return "Failed to load tour: \(error.localizedDescription)"
        }
    }
}

struct ToursService {
    func loadTours(cityId: Int64 = 1) async throws -> [TourSummary] {
        try await Task.detached(priority: .userInitiated) {
            let name = "routes_\(cityId)"
            guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
                throw ToursError.fileNotFound(name)
            }
            do {
                let data = try Data(contentsOf: url)
                let response = try JSONDecoder().decode(ToursResponse.self, from: data)
                return response.routes
            } catch let e as DecodingError {
                throw ToursError.decodingFailed(e)
            }
        }.value
    }

    func loadTourDetail(id: Int64) async throws -> TourDetail {
        try await Task.detached(priority: .userInitiated) {
            let name = "route_detail_\(id)"
            guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
                throw ToursError.fileNotFound(name)
            }
            do {
                let data = try Data(contentsOf: url)
                return try JSONDecoder().decode(TourDetail.self, from: data)
            } catch let e as DecodingError {
                throw ToursError.decodingFailed(e)
            }
        }.value
    }
}
