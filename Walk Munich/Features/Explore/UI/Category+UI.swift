//
//  CategoryUI.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct CategoryUI {
    let title: String
    let systemImageName: String
}

extension Category {
    var ui: CategoryUI {
        switch self {
        case .landmark:
            return CategoryUI(title: String(localized: "category_attraction"), systemImageName: "building.columns")
        case .museum:
            return CategoryUI(title: String(localized: "category_museum"), systemImageName: "building")
        case .viewpoint:
            return CategoryUI(title: String(localized: "category_viewpoint"), systemImageName: "binoculars")
        case .coffee:
            return CategoryUI(title: String(localized: "category_coffee"), systemImageName: "cup.and.saucer")
        case .food:
            return CategoryUI(title: String(localized: "category_food"), systemImageName: "fork.knife")
        }
    }
}
