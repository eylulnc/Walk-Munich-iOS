//
//  ToursView.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct ToursView: View {
    @State private var viewModel = ToursViewModel()
    let onTourTap: (Int64) -> Void

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let errorMessage = viewModel.error {
                VStack(spacing: Spacing.medium) {
                    Text(errorMessage)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    Button(String(localized: "retry")) {
                        Task { await viewModel.loadTours() }
                    }
                }
                .padding(Spacing.large)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                toursList
            }
        }
        .navigationTitle("tab_tours")
        .navigationBarTitleDisplayMode(.large)
    }

    private var toursList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.large) {
                VStack(alignment: .leading, spacing: Spacing.small) {
                    Text("tour_header_title")
                        .font(.headline)
                    Text("tour_header_subtitle")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, Spacing.medium)
                .padding(.top, Spacing.small)

                LazyVStack(spacing: Spacing.medium) {
                    ForEach(viewModel.tours) { tour in
                        TourCard(tour: tour) {
                            onTourTap(tour.id)
                        }
                    }
                }
                .padding(.horizontal, Spacing.medium)
            }
            .padding(.bottom, Spacing.large)
        }
    }
}

// MARK: - Tour Card

private struct TourCard: View {
    let tour: TourSummary
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomLeading) {
                    tourImage
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                        .clipped()

                    LinearGradient(
                        colors: [.clear, .black.opacity(0.65)],
                        startPoint: .center,
                        endPoint: .bottom
                    )
                    .frame(height: 180)

                    Text(tour.title)
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                        .padding(Spacing.medium)
                }

                if let summary = tour.summary, !summary.isEmpty {
                    Text(summary)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                        .padding(.horizontal, Spacing.medium)
                        .padding(.vertical, Spacing.small)
                }
            }
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color(.systemGray4).opacity(0.5), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }

    private var tourImage: some View {
        Group {
            if let imageUrl = tour.imageUrl, UIImage(named: imageUrl) != nil {
                Image(imageUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                PlaceholderImageView()
                //Image("hero_munich").resizable().aspectRatio(contentMode: .fill)
            }
        }
    }
}
