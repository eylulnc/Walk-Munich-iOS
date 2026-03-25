//
//  Category.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//


import SwiftUI

enum Category: String, Codable, CaseIterable {
    case landmark = "LANDMARK"
    case museum = "MUSEUM"
    case viewpoint = "VIEWPOINT"
    case coffee = "COFFEE"
    case food = "FOOD"
}
