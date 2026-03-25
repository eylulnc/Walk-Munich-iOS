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
            return CategoryUI(title: "Attraction", systemImageName: "building.columns")
        case .museum:
            return CategoryUI(title: "Museum", systemImageName: "building")
        case .viewpoint:
            return CategoryUI(title: "Viewpoint", systemImageName: "binoculars")
        case .coffee:
            return CategoryUI(title: "Coffee", systemImageName: "cup.and.saucer")
        case .food:
            return CategoryUI(title: "Food", systemImageName: "fork.knife")
        }
    }
}
