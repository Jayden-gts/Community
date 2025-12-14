//
//  MapModels.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-12-13. 991691793
//


import Foundation
import SwiftUI
import CoreLocation

struct UserLocation: Identifiable {
    let id: UUID
    let coordinate: CLLocationCoordinate2D
}

struct MapTabView_Previews: PreviewProvider {
    static var previews: some View {
        MapTabView()
    }
}
