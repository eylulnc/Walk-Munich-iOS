//
//  PlaceholderImageView.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

/// Shown whenever a place-specific image asset isn't available yet.
/// Uses the same orange → teal gradient look as the Highlight of the Day card.
struct PlaceholderImageView: View {
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [
                        WalkMunichTheme.primary.opacity(0.6),
                        WalkMunichTheme.secondary.opacity(0.6)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundStyle(.white.opacity(0.5))
            )
    }
}
