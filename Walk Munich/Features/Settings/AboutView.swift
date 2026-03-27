//
//  AboutView.swift
//  Walk Munich
//

import SwiftUI

struct AboutView: View {
    let onDetailTap: (String, String) -> Void

    private let items: [(title: String, contentKey: String)] = [
        (String(localized: "about_app_description_title"), "about_app_description_content"),
        (String(localized: "about_disclaimer_title"),      "about_disclaimer_content"),
        (String(localized: "about_attribution_title"),     "about_attribution_content"),
        (String(localized: "about_impressum_title"),       "about_impressum_content"),
    ]

    var body: some View {
        List {
            Section {
                ForEach(items, id: \.title) { item in
                    Button {
                        onDetailTap(item.title, String(localized: String.LocalizationValue(item.contentKey)))
                    } label: {
                        HStack {
                            Text(item.title)
                                .foregroundStyle(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }

            Section {
                VStack(spacing: Spacing.small) {
                    Text(appVersion)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Text("about_footer")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("settings_about_app")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "Version \(version) (\(build))"
    }
}
