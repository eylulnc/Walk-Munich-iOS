//
//  ContentView.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {

            ExploreNavigation()
                .tabItem {
                    Label(AppTab.explore.title,
                          systemImage: AppTab.explore.systemImage)
                }

            ToursNavigation()
                .tabItem {
                    Label(AppTab.tours.title,
                          systemImage: AppTab.tours.systemImage)
                }

            FavoritesNavigation()
                .tabItem {
                    Label(AppTab.favorites.title,
                          systemImage: AppTab.favorites.systemImage)
                }

            SettingsNavigation()
                .tabItem {
                    Label(AppTab.settings.title,
                          systemImage: AppTab.settings.systemImage)
                }
        }
    }
}

#Preview {
    ContentView()
}
