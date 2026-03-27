//
//  Walk_MunichApp.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI

@main
struct Walk_MunichApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(WalkMunichTheme.primary)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
