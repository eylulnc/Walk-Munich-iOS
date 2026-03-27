//
//  ContentView.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: AppTab = .explore

    var body: some View {
        TabView(selection: $selectedTab) {

            ExploreNavigation(selectedTab: $selectedTab)
                .tabItem {
                    Label(AppTab.explore.title,
                          systemImage: AppTab.explore.systemImage)
                }
                .tag(AppTab.explore)

            ToursNavigation()
                .tabItem {
                    Label(AppTab.tours.title,
                          systemImage: AppTab.tours.systemImage)
                }
                .tag(AppTab.tours)

            MapNavigation()
                .tabItem {
                    Label(AppTab.map.title,
                          systemImage: AppTab.map.systemImage)
                }
                .tag(AppTab.map)

            FavoritesNavigation()
                .tabItem {
                    Label(AppTab.favorites.title,
                          systemImage: AppTab.favorites.systemImage)
                }
                .tag(AppTab.favorites)

            SettingsNavigation()
                .tabItem {
                    Label(AppTab.settings.title,
                          systemImage: AppTab.settings.systemImage)
                }
                .tag(AppTab.settings)
        }
    }
}

#Preview {
    ContentView()
}
