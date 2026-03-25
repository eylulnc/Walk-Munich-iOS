//
//  SearchResult.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

struct SearchResult: Identifiable {
    var id: Int64 { place.id }
    let place: Place
    let category: Category
}
