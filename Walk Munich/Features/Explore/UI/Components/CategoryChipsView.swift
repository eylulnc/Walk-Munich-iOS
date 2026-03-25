//
//  CategoryChipsView.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct CategoryChipsView: View {
    @Binding var selectedCategory: Category?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.small) {
                CategoryChip(
                    title: "All",
                    systemImage: "square.grid.2x2",
                    isSelected: selectedCategory == nil
                ) {
                    selectedCategory = nil
                }

                ForEach(Category.allCases, id: \.self) { category in
                    CategoryChip(
                        title: category.ui.title,
                        systemImage: category.ui.systemImageName,
                        isSelected: selectedCategory == category
                    ) {
                        selectedCategory = selectedCategory == category ? nil : category
                    }
                }
            }
            .padding(.horizontal, Spacing.medium)
        }
    }
}

private struct CategoryChip: View {
    let title: String
    let systemImage: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label(title, systemImage: systemImage)
                .font(.subheadline)
                .padding(.horizontal, Spacing.small + 4)
                .padding(.vertical, Spacing.small)
                .background(isSelected ? WalkMunichTheme.primary : Color(.secondarySystemBackground))
                .foregroundStyle(isSelected ? Color.white : Color.primary)
                .clipShape(Capsule())
        }
    }
}
