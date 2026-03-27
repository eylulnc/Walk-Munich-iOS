//
//  Tour.swift
//  Walk Munich
//

import Foundation

struct TourSummary: Codable, Identifiable {
    let id: Int64
    let title: String
    let summary: String?
    let imageUrl: String?
}

struct ToursResponse: Codable {
    let cityId: Int64
    let routes: [TourSummary]
}

struct TourDetail: Codable, Identifiable {
    let id: Int64
    let cityId: Int64
    let title: String
    let segments: [TourSegment]
    let imageUrl: String?
    let summary: String?
    let updatedAt: String
}

struct TourSegment: Codable, Identifiable {
    let id: Int64
    let title: String
    let dayIndex: Int
    let stops: [TourStop]
}

struct TourStop: Codable {
    let ord: Int
    let placeId: Int64
    let name: String
    let category: Category
}
