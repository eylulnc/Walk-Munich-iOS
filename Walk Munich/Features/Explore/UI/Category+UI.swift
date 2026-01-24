//
//  CategoryUI.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//


import SwiftUI

struct CategoryUI {
    let titleKey: LocalizedStringKey
    let systemImageName: String
}

// Usage example:
// let info = Category.landmark.ui
// Text(info.titleKey)
// Image(systemName: info.systemImageName)


extension Category {
    var ui: CategoryUI {
        switch self {
        case .landmark:
            return CategoryUI(
                titleKey: "category_attraction",
                systemImageName: "building.columns"
            )
        case .museum:
            return CategoryUI(
                titleKey: "category_museum",
                systemImageName: "building"
            )
        case .viewpoint:
            return CategoryUI(
                titleKey: "category_viewpoint",
                systemImageName: "binoculars"
            )
        case .coffee:
            return CategoryUI(
                titleKey: "category_coffee",
                systemImageName: "cup.and.saucer"
            )
        case .food:
            return CategoryUI(
                titleKey: "category_food",
                systemImageName: "fork.knife"
            )
        }
    }
}
