//
//  PlacesResponse.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import Foundation

struct PlacesResponse: Codable {
    let cityId: Int64
    let cityName: String
    let updatedAt: String
    let places: [Place]
}

struct Place: Codable, Identifiable {
    let id: Int64
    let cityId: Int64
    let name: String
    let category: Category
    let imageUrl: String
    let coords: Coordinates?
    let address: String?
    let openingHoursText: String?
    let priceRange: PriceRange?
    let tags: [String]?
    let otherImages: [String]?
    let story: PlaceStory?
    let facts: [Fact]?
    let attribution: [Attribution]?
    let updatedAt: String
}

struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}

struct PlaceStory: Codable {
    let mainTitle: String
    let subTitle: String?
    let overview: String
    let highlights: [Highlight]
}

struct Highlight: Codable {
    let title: String
    let text: String
}

struct Fact: Codable {
    let text: String
    let sourceName: String
    let sourceUrl: String?
}

struct Attribution: Codable {
    let text: String
    let url: String?
}

enum PriceRange: String, Codable {
    case low = "LOW"
    case medium = "MEDIUM"
    case high = "HIGH"
}
