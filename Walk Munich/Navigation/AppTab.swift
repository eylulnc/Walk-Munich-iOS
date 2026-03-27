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
            return String(localized: "tab_explore")
        case .tours:
            return String(localized: "tab_tours")
        case .map:
            return String(localized: "tab_map")
        case .favorites:
            return String(localized: "tab_favorites")
        case .settings:
            return String(localized: "tab_settings")
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
