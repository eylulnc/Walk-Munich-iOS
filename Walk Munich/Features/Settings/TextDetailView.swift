//
//  TextDetailView.swift
//  Walk Munich
//

import SwiftUI

struct TextDetailView: View {
    let title: String
    let content: String

    var body: some View {
        ScrollView {
            Text(content)
                .font(.body)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(Spacing.large)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
