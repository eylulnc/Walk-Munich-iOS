//
//  AppTab.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//


import SwiftUI

enum AppTab: CaseIterable {
    case explore
    case tours
    case map
    case favorites
    case settings

    var title: String {
        switch self {
        case .explore:
            return "Explore"
        case .tours:
            return "Tours"
        case .map:
            return "Map"
        case .favorites:
            return "Favorites"
        case .settings:
            return "Settings"
        }
    }

    var systemImage: String {
        switch self {
        case .explore:
            return "map"
        case .tours:
            return "figure.walk"
        case .map:
            return "location.fill"
        case .favorites:
            return "heart"
        case .settings:
            return "gear"
        }
    }
}
