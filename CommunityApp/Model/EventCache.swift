//
//  EventCache.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-12-13.
//

import Foundation
import CoreLocation
final class EventCoordinateCache {
    static let shared = EventCoordinateCache()
    private init() {}
    private var cache: [String: CLLocationCoordinate2D] = [:]
    func get(eventId: String) -> CLLocationCoordinate2D? {
        cache[eventId]
    }
    func set(_ coordinate: CLLocationCoordinate2D, for eventId: String) {
        cache[eventId] = coordinate
    }
}

