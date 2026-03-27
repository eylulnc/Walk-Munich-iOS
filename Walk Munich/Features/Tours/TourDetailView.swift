//
//  TourDetailView.swift
//  Walk Munich
//

import SwiftUI

struct TourDetailView: View {
    @State private var viewModel: TourDetailViewModel
    @Environment(\.dismiss) private var dismiss
    let onStopTap: (Int64) -> Void

    init(tourId: Int64, onStopTap: @escaping (Int64) -> Void = { _ in }) {
        _viewModel = State(initialValue: TourDetailViewModel(tourId: tourId))
        self.onStopTap = onStopTap
    }

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
                        Task { await viewModel.loadTourDetail() }
                    }
                }
                .padding(Spacing.large)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let detail = viewModel.tourDetail {
                TourDetailContent(detail: detail, onBack: { dismiss() }, onStopTap: onStopTap)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

// MARK: - Content

private struct TourDetailContent: View {
    let detail: TourDetail
    let onBack: () -> Void
    var onStopTap: ((Int64) -> Void)?

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 0) {

                    ZStack(alignment: .top) {
                        heroImage
                            .frame(height: 280)
                            .clipped()

                        LinearGradient(
                            colors: [.black.opacity(0.5), .clear],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 280)

                        HStack {
                            CircleTourButton(systemImage: "chevron.left", action: onBack)
                            Spacer()
                        }
                        .padding(.horizontal, Spacing.medium)
                        .padding(.top, proxy.safeAreaInsets.top + Spacing.extraSmall)
                    }


                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading, spacing: Spacing.small) {
                            Text(detail.title)
                                .font(.title2.bold())

                            if let summary = detail.summary, !summary.isEmpty {
                                Text(summary)
                                    .font(.body)
                                    .foregroundStyle(.secondary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                        .padding(.horizontal, Spacing.large)
                        .padding(.top, Spacing.large)
                        .padding(.bottom, Spacing.medium)

                        Divider()
                            .padding(.horizontal, Spacing.large)

                        // Itinerary
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: Spacing.small) {
                                Image(systemName: "map")
                                    .font(.subheadline)
                                    .foregroundStyle(WalkMunichTheme.primary)
                                Text("tour_itinerary")
                                    .font(.headline)
                            }
                            .padding(.horizontal, Spacing.large)
                            .padding(.vertical, Spacing.medium)

                            ForEach(detail.segments) { segment in
                                ItinerarySegmentView(
                                    segment: segment,
                                    showDayHeader: detail.segments.count > 1,
                                    onStopTap: onStopTap
                                )
                            }
                        }
                    }
                    .background(Color(.systemBackground))
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 28, topTrailingRadius: 28))
                    .offset(y: -24)
                    .padding(.bottom, -24)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
    }

    private var heroImage: some View {
        Group {
            if let imageUrl = detail.imageUrl, UIImage(named: imageUrl) != nil {
                Image(imageUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                PlaceholderImageView()
            }
        }
    }
}

// MARK: - Itinerary Segment

private struct ItinerarySegmentView: View {
    let segment: TourSegment
    let showDayHeader: Bool
    var onStopTap: ((Int64) -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if showDayHeader {
                HStack(spacing: Spacing.small) {
                    Image(systemName: "calendar")
                        .font(.subheadline)
                        .foregroundStyle(WalkMunichTheme.primary)
                    Text(segment.title)
                        .font(.subheadline.bold())
                        .foregroundStyle(WalkMunichTheme.primary)
                }
                .padding(.horizontal, Spacing.large)
                .padding(.bottom, Spacing.medium)
            }

            ForEach(Array(segment.stops.enumerated()), id: \.element.ord) { index, stop in
                StopRow(
                    stop: stop,
                    stepNumber: index + 1,
                    isLast: index == segment.stops.count - 1,
                    onTap: onStopTap.map { tap in { tap(stop.placeId) } }
                )
            }
        }
        .padding(.bottom, Spacing.medium)
    }
}

// MARK: - Stop Row

private struct StopRow: View {
    let stop: TourStop
    let stepNumber: Int
    let isLast: Bool
    var onTap: (() -> Void)?

    var body: some View {
        HStack(alignment: .top, spacing: Spacing.medium) {
            // Step number + dashed connector
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(WalkMunichTheme.primary)
                        .frame(width: 32, height: 32)
                    Text("\(stepNumber)")
                        .font(.caption.bold())
                        .foregroundStyle(.white)
                }

                if !isLast {
                    DashedVerticalLine()
                        .frame(width: 2)
                        .frame(maxHeight: .infinity)
                        .padding(.vertical, Spacing.extraSmall)
                }
            }
            .frame(width: 32)

            Button(action: { onTap?() }) {
                StopCard(stop: stop)
            }
            .buttonStyle(.plain)
            .disabled(onTap == nil)
            .padding(.bottom, isLast ? 0 : Spacing.medium)
        }
        .padding(.horizontal, Spacing.large)
        .padding(.bottom, isLast ? Spacing.small : 0)
    }
}

// MARK: - Stop Card

private struct StopCard: View {
    let stop: TourStop

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                stopImage
                    .frame(maxWidth: .infinity)
                    .frame(height: 110)
                    .clipped()

                Image(systemName: stop.category.ui.systemImageName)
                    .font(.caption.bold())
                    .foregroundStyle(.white)
                    .padding(Spacing.extraSmall)
                    .background(Color.black.opacity(0.3))
                    .clipShape(Circle())
                    .padding(Spacing.small)
            }

            Text(stop.name)
                .font(.subheadline.bold())
                .foregroundStyle(.primary)
                .lineLimit(1)
                .padding(.horizontal, Spacing.small)
                .padding(.vertical, Spacing.small)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color(.systemGray4).opacity(0.5), lineWidth: 1)
        )
        .frame(maxWidth: .infinity)
    }

    private var stopImage: some View {
        Group {
            if UIImage(named: stop.name.lowercased().replacingOccurrences(of: " ", with: "_")) != nil {
                Image(stop.name.lowercased().replacingOccurrences(of: " ", with: "_"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                PlaceholderImageView()
            }
        }
    }
}

// MARK: - Dashed Line

private struct DashedVerticalLine: View {
    var body: some View {
        Canvas { context, size in
            var path = Path()
            path.move(to: CGPoint(x: size.width / 2, y: 0))
            path.addLine(to: CGPoint(x: size.width / 2, y: size.height))
            context.stroke(
                path,
                with: .color(WalkMunichTheme.primary.opacity(0.4)),
                style: StrokeStyle(lineWidth: 2, dash: [6, 6])
            )
        }
    }
}

// MARK: - Circle Button

private struct CircleTourButton: View {
    let systemImage: String
    var tint: Color = .white
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.callout.bold())
                .foregroundStyle(tint)
                .padding(Spacing.small)
                .frame(width: 40, height: 40)
                .background(Color.black.opacity(0.15))
                .clipShape(Circle())
        }
    }
}
