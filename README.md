# Walk Munich – iOS

Walk Munich is an iOS app for discovering and exploring Munich.
It helps you find interesting places, browse curated walking routes, and navigate between stops, all using native Apple frameworks with no API key required.

It's still **a work in progress**, built as a personal project to learn and experiment with SwiftUI architecture, navigation patterns, and iOS best practices.

---

## 📍 Overview

Instead of juggling notes, maps, and screenshots, the goal is one app where you can:

- Discover places worth visiting, filtered by category
- Browse and follow curated walking routes
- View place details with descriptions and photos
- Save favorites and revisit recently viewed places
- See all places on an interactive map with category markers
- Navigate directly to any place via Apple Maps

---

## ⚙️ Current Features

- **Explore** — Full place list with category chip filtering, highlights, recently viewed, and favorites sections
- **Place Detail** — Photo, description, highlights, and coordinates for each stop
- **Tours** — Browse curated walking itineraries with a full tour detail view
- **Map** — Interactive MapKit map with color-coded category markers; tap a pin to preview a place and open walking directions in Apple Maps
- **Favorites** — Save and manage favorite places
- **Settings** — App preferences and About section

---

## 🧱 Tech Stack

- **Language:** Swift
- **UI:** SwiftUI
- **Navigation:** `TabView` + `NavigationStack` (route-based)
- **Architecture:** MVVM, feature-based modular structure
- **State Management:** `@Observable`, `@State`, `@Environment`
- **Maps:** MapKit (no API key required)
- **Location:** CoreLocation
- **No external dependencies** — built entirely with native Apple frameworks

---

## 📸 Preview

| Explore | Search |
|---------|--------|
| ![Explore](/ss/explore.png) | ![Search](/ss/search.png) |

| Tour List | Tour Detail |
|-----------|-------------|
| ![Tours](/ss/tour.png) | ![Tour Detail](/ss/tour_detail.png) |

| Map | Map Detail | Favorites | Favorites Grid | Settings |
|-----|------------|-----------|----------------|----------|
| ![Map](/ss/map1.png) | ![Map Detail](/ss/map2.png) | ![Favorites](/ss/fav1.png) | ![Favorites Grid](/ss/fav2.png) | ![Settings](/ss/setting.png) |

---

## 🚧 Planned

- Custom route creation and saving
- Search across places and routes

---

## ⚠️ Disclaimer

This project is developed for **educational and personal learning purposes** only.
It is not an official travel or navigation app and does not guarantee the accuracy of location or historical information.
All content and media are intended for non-commercial use as part of an ongoing learning project.

---

## 📄 License

This project is licensed under the **MIT License**.
You are free to use, modify, and distribute this project for learning or personal purposes, as long as proper credit is given.
