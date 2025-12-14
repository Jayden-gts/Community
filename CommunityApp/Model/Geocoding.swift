//
//  Geocoding.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-12-13.
//

import Foundation
import CoreLocation
final class GeocodingService {
    static let shared = GeocodingService()
    private let geocoder = CLGeocoder()
    private init() {}
    func geocode(address: String) async -> CLLocationCoordinate2D? {
        guard !address.isEmpty else { return nil }
        do {
            let placemarks = try await geocoder.geocodeAddressString(address)
            return placemarks.first?.location?.coordinate
        } catch {
            print("Geocoding failed for address:", address, error)
            return nil
        }
    }
}
