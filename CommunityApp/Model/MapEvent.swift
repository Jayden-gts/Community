//
//  MapEvent.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-12-13.
//



import Foundation
import CoreLocation

struct MapEvent: Identifiable {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
    
    let originalEvent: AnyEvent
}
