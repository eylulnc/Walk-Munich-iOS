//
//  MapView.swift
//  Walk Munich
//
//  Created by Eylul Naz Can on 24.01.2026.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State private var viewModel = MapViewModel()
    @State private var locationManager = LocationManager()
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 48.1351, longitude: 11.5820),
            span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
        )
    )
    @State private var selectedPlace: Place?

    let onPlaceTap: (Int64) -> Void

    var body: some View {
        ZStack(alignment: .bottom) {
            Map(position: $cameraPosition) {
                ForEach(viewModel.places) { place in
                    if let coords = place.coords {
                        Annotation(
                            place.name,
                            coordinate: CLLocationCoordinate2D(latitude: coords.lat, longitude: coords.lon),
                            anchor: .bottom
                        ) {
                            CategoryMarkerView(category: place.category)
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.25)) {
                                        selectedPlace = place
                                    }
                                }
                        }
                    }
                }
                if locationManager.isAuthorized {
                    UserAnnotation()
                }
            }
            .mapStyle(.standard(elevation: .realistic))
            .ignoresSafeArea(edges: .top)

            if locationManager.isAuthorized {
                MapFloatingButton(
                    systemImage: "location.fill",
                    accessibilityLabel: String(localized: "map_my_location")
                ) {
                    moveToUserLocation()
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                .padding(.leading, Spacing.medium)
                .padding(.top, Spacing.small)
                .animation(.easeInOut(duration: 0.25), value: selectedPlace != nil)
            }
            
            if let place = selectedPlace {
                MapPlaceCard(
                    place: place,
                    onClose: {
                        withAnimation(.easeOut(duration: 0.2)) { selectedPlace = nil }
                    },
                    onTap: { onPlaceTap(place.id) }
                )
                .padding(.bottom, Spacing.large)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .onAppear {
            locationManager.requestPermission()
        }
        .overlay(alignment: .center) {
            if viewModel.isLoading {
                ProgressView()
                    .padding(Spacing.medium)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private func moveToUserLocation() {
        guard let location = locationManager.userLocation else { return }
        withAnimation {
            cameraPosition = .region(MKCoordinateRegion(
                center: location,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            ))
        }
    }
}

// MARK: - Map Place Card (compact, fixed-width)

private struct MapPlaceCard: View {
    let place: Place
    let onClose: () -> Void
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image with overlay buttons
            ZStack(alignment: .top) {
                Group {
                    if UIImage(named: place.imageUrl) != nil {
                        Image(place.imageUrl)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        PlaceholderImageView()
                    }
                }
                .frame(width: 180, height: 110)
                .clipped()

                HStack {
                    // Close button
                    Button(action: onClose) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.callout)
                            .foregroundStyle(.white)
                            .shadow(radius: 2)
                    }
                    Spacer()
                    // Favorite button
                    Button {
                        UserPreferencesService.shared.toggleFavorite(place.id)
                    } label: {
                        Image(systemName: UserPreferencesService.shared.isFavorite(place.id) ? "heart.fill" : "heart")
                            .font(.callout)
                            .foregroundStyle(UserPreferencesService.shared.isFavorite(place.id) ? Color.red : .white)
                            .shadow(radius: 2)
                    }
                }
                .padding(Spacing.small)
            }

            // Name + navigate row
            HStack(spacing: Spacing.extraSmall) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(place.name)
                        .font(.subheadline.bold())
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                    Label(place.category.ui.title, systemImage: place.category.ui.systemImageName)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                Spacer(minLength: 0)
                if let coords = place.coords {
                    Button {
                        openInMaps(lat: coords.lat, lon: coords.lon, name: place.name)
                    } label: {
                        Image(systemName: "arrow.triangle.turn.up.right.circle.fill")
                            .font(.title2)
                            .foregroundStyle(Color.accentColor)
                    }
                }
            }
            .padding(.horizontal, Spacing.small)
            .padding(.vertical, Spacing.small)
        }
        .frame(width: 180)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.18), radius: 8, y: 4)
        .onTapGesture(perform: onTap)
    }

    private func openInMaps(lat: Double, lon: Double, name: String) {
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.name = name
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking
        ])
    }
}

// MARK: - Category Marker

private struct CategoryMarkerView: View {
    let category: Category

    var body: some View {
        ZStack {
            Circle()
                .fill(category.markerColor)
                .frame(width: 32, height: 32)
            Image(systemName: category.ui.systemImageName)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.white)
        }
        .shadow(color: .black.opacity(0.25), radius: 3, y: 2)
    }
}

// MARK: - Floating Button

private struct MapFloatingButton: View {
    let systemImage: String
    let accessibilityLabel: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 18))
                .foregroundStyle(Color.accentColor)
                .frame(width: 44, height: 44)
                .background(.regularMaterial, in: Circle())
                .shadow(color: .black.opacity(0.15), radius: 4, y: 2)
        }
        .accessibilityLabel(accessibilityLabel)
    }
}

// MARK: - Category Marker Colors

extension Category {
    var markerColor: Color {
        switch self {
        case .landmark:  return WalkMunichColors.redError
        case .museum:    return WalkMunichColors.blueTeal
        case .viewpoint: return WalkMunichColors.green
        case .coffee:    return WalkMunichColors.orangeMain
        case .food:      return WalkMunichColors.yellow
        }
    }
}

// MARK: - Location Manager

@Observable
final class LocationManager: NSObject {
    var isAuthorized = false
    var userLocation: CLLocationCoordinate2D?

    private let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    func requestPermission() {
        let status = manager.authorizationStatus
        if status == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else {
            isAuthorized = status == .authorizedWhenInUse || status == .authorizedAlways
            if isAuthorized { manager.requestLocation() }
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        isAuthorized = status == .authorizedWhenInUse || status == .authorizedAlways
        if isAuthorized { manager.requestLocation() }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last?.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
}
