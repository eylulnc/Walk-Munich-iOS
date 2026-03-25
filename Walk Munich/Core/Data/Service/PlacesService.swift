//
//  PlacesService.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import Foundation

enum PlacesError: LocalizedError {
    case fileNotFound
    case decodingFailed(Error)

    var errorDescription: String? {
        switch self {
        case .fileNotFound: return "Place data file not found."
        case .decodingFailed(let error): return "Failed to load places: \(error.localizedDescription)"
        }
    }
}

struct PlacesService {
    func loadPlaces() async throws -> [Place] {
        try await Task.detached(priority: .userInitiated) {
            guard let url = Bundle.main.url(forResource: "place", withExtension: "json") else {
                throw PlacesError.fileNotFound
            }
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(PlacesResponse.self, from: data)
                return response.places
            } catch let decodeError as DecodingError {
                throw PlacesError.decodingFailed(decodeError)
            }
        }.value
    }
}
