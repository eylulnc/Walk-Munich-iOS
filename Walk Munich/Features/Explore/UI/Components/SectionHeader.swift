//
//  SectionHeader.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct SectionHeader: View {
    let title: LocalizedStringKey
    let onSeeAll: (() -> Void)?

    init(_ title: LocalizedStringKey, onSeeAll: (() -> Void)? = nil) {
        self.title = title
        self.onSeeAll = onSeeAll
    }

    init(title: String, onSeeAll: (() -> Void)? = nil) {
        self.title = LocalizedStringKey(title)
        self.onSeeAll = onSeeAll
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.title3.bold())
            Spacer()
            if let onSeeAll {
                Button("see_all", action: onSeeAll)
                    .font(.subheadline)
                    .foregroundStyle(WalkMunichTheme.primary)
            }
        }
    }
}
