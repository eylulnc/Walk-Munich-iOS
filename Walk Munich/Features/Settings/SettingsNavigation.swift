//
//  SettingsNavigation.swift
//  Walk Munich
//

import SwiftUI

enum SettingsRoute: Hashable {
    case about
    case textDetail(title: String, content: String)
}

struct SettingsNavigation: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            SettingsView(onAboutTap: {
                path.append(SettingsRoute.about)
            })
            .navigationDestination(for: SettingsRoute.self) { route in
                switch route {
                case .about:
                    AboutView { title, content in
                        path.append(SettingsRoute.textDetail(title: title, content: content))
                    }
                case .textDetail(let title, let content):
                    TextDetailView(title: title, content: content)
                }
            }
        }
    }
}
