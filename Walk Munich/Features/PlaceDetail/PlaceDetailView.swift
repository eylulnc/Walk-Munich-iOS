//
//  PlaceDetailView.swift
//  Walk Munich
//

import SwiftUI

struct PlaceDetailView: View {
    @State private var viewModel: PlaceDetailViewModel
    @Environment(\.dismiss) private var dismiss

    init(placeId: Int64) {
        _viewModel = State(initialValue: PlaceDetailViewModel(placeId: placeId))
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
                    Button("retry") { Task { await viewModel.loadPlace() } }
                }
                .padding(Spacing.large)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let place = viewModel.place {
                PlaceDetailContent(
                    place: place,
                    isFavorite: viewModel.isFavorite,
                    onBack: { dismiss() },
                    onFavoriteTap: viewModel.toggleFavorite
                )
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

// MARK: - Circle hero button

private struct CircleHeroButton: View {
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

// MARK: - Content

private struct PlaceDetailContent: View {
    let place: Place
    let isFavorite: Bool
    let onBack: () -> Void
    let onFavoriteTap: () -> Void

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    ZStack(alignment: .top) {
                        ZStack {
                            if UIImage(named: place.imageUrl) != nil {
                                Image(place.imageUrl)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } else {
                                PlaceholderImageView()
                            }
                        }
                        .frame(height: 300)
                        .clipped()

                        HStack {
                            CircleHeroButton(systemImage: "chevron.left", action: onBack)
                            Spacer()
                            CircleHeroButton(
                                systemImage: isFavorite ? "heart.fill" : "heart",
                                tint: isFavorite ? .red : .white,
                                action: onFavoriteTap
                            )
                        }
                        .padding(.horizontal, Spacing.medium)
                        .padding(.vertical, Spacing.small)
                        .padding(.top, proxy.safeAreaInsets.top)
                    }

                    if let story = place.story {
                        StoryContent(place: place, story: story)
                            .offset(y: -28)
                            .padding(.bottom, -28)
                    }
                }
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}

// MARK: - Story

private struct StoryContent: View {
    let place: Place
    let story: PlaceStory

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            Text(place.name)
                .font(.title.bold())
                .foregroundStyle(.primary)

            if let subTitle = story.subTitle, !subTitle.isEmpty {
                Text(subTitle)
                    .font(.title3.bold())
                    .foregroundStyle(WalkMunichColors.textMutedDark)
            }

            Spacer().frame(height: Spacing.small)

            Text(story.overview)
                .font(.body)
                .foregroundStyle(.primary)

            if !story.highlights.isEmpty {
                HighlightsSection(highlights: story.highlights)
            }

            if let facts = place.facts, !facts.isEmpty {
                ExpandableSection(
                    title: String(localized: "fun_facts"),
                    content: facts.map { "• \($0.text)" }.joined(separator: "\n")
                )
            }
        }
        .padding(.horizontal, Spacing.large)
        .padding(.vertical, Spacing.large)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 32,
                topTrailingRadius: 32
            )
        )
    }
}

// MARK: - Highlights

private struct HighlightsSection: View {
    let highlights: [Highlight]

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            Spacer().frame(height: Spacing.large)

            Text("highlights")
                .font(.headline)
                .foregroundStyle(.primary)

            Spacer().frame(height: Spacing.extraSmall)

            ForEach(highlights, id: \.title) { highlight in
                (Text(highlight.title).bold() + Text(": ") + Text(highlight.text))
                    .font(.body)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, Spacing.extraSmall)
            }
        }
    }
}
