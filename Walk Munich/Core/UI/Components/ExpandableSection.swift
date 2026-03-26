//
//  ExpandableSection.swift
//  Walk Munich
//

import SwiftUI

struct ExpandableSection: View {
    let title: String
    let content: String
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
                .padding(.vertical, Spacing.small)

            Button {
                withAnimation(.easeInOut(duration: 0.2)) { isExpanded.toggle() }
            } label: {
                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.secondary)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .animation(.easeInOut(duration: 0.2), value: isExpanded)
                }
            }
            .buttonStyle(.plain)

            if isExpanded {
                Text(content)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .padding(.top, Spacing.small)
            }

            Divider()
                .padding(.top, Spacing.small)
        }
        .padding(.vertical, Spacing.small)
    }
}
