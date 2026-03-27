//
//  SettingsView.swift
//  Walk Munich
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showClearHistoryAlert = false
    @State private var showClearFavoritesAlert = false

    private let preferences = UserPreferencesService.shared
    let onAboutTap: () -> Void

    var body: some View {
        List {
            // App header
            Section {
                HStack(spacing: Spacing.medium) {
                    appIcon
                    VStack(alignment: .leading, spacing: 2) {
                        Text("app_title")
                            .font(.headline)
                        Text(appVersion)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, Spacing.extraSmall)
                .listRowBackground(Color.clear)
            }

            // Appearance
            Section(String(localized: "settings_appearance")) {
                HStack {
                    Label("settings_dark_mode", systemImage: "moon")
                        .foregroundStyle(.primary)
                    Spacer()
                    Toggle("", isOn: $isDarkMode)
                        .labelsHidden()
                }
            }

            // Data
            Section(String(localized: "settings_data")) {
                Button {
                    showClearHistoryAlert = true
                } label: {
                    Label("settings_clear_recently_viewed", systemImage: "clock.arrow.circlepath")
                }
                .tint(.primary)

                Button(role: .destructive) {
                    showClearFavoritesAlert = true
                } label: {
                    Label("settings_clear_favorites", systemImage: "heart.slash")
                }
            }

            // About
            Section(String(localized: "settings_about_section")) {
                Button(action: onAboutTap) {
                    HStack {
                        Label("settings_about_app", systemImage: "info.circle")
                            .foregroundStyle(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                HStack {
                    Label("settings_version", systemImage: "tag")
                        .foregroundStyle(.primary)
                    Spacer()
                    Text(appVersion)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("settings_title")
        .navigationBarTitleDisplayMode(.large)
        .alert(String(localized: "settings_clear_recently_viewed"), isPresented: $showClearHistoryAlert) {
            Button(String(localized: "alert_clear"), role: .destructive) {
                preferences.clearRecentlyViewed()
            }
            Button(String(localized: "alert_cancel"), role: .cancel) {}
        } message: {
            Text("alert_clear_recently_viewed_message")
        }
        .alert(String(localized: "settings_clear_favorites"), isPresented: $showClearFavoritesAlert) {
            Button(String(localized: "alert_clear"), role: .destructive) {
                preferences.clearFavorites()
            }
            Button(String(localized: "alert_cancel"), role: .cancel) {}
        } message: {
            Text("alert_clear_favorites_message")
        }
    }

    private var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(version) (\(build))"
    }

    private var appIcon: some View {
        Group {
            if let icon = UIImage(named: "AppIcon") {
                Image(uiImage: icon)
                    .resizable()
                    .frame(width: 56, height: 56)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(WalkMunichTheme.primary)
                    .frame(width: 56, height: 56)
                    .overlay(
                        Image(systemName: "map")
                            .font(.title2)
                            .foregroundStyle(.white)
                    )
            }
        }
    }
}
