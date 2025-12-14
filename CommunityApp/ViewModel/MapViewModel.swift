//
//  MapViewModel.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-11-18.
//

import Foundation
import MapKit
import CoreLocation


class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var mapEvents: [MapEvent] = []

    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D( latitude: 43.6532, longitude: -79.3832),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    @Published var userLocation: CLLocationCoordinate2D?
    
    private let locationManager = CLLocationManager()
    
    override init (){
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation(){
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // added this might change later ****
    func checkAuthorizationStatus() {
        switch locationManager.authorizationStatus {
        case.notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            print("Location access denied or restricted")
        @unknown default:
            break
        }
    }
    
    
    // check this later
    func locationManagerDidChangeAuthorization( _manager: CLLocationManager){
        checkAuthorizationStatus()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let first = locations.first
        else {
            return
        }
        userLocation = first.coordinate
        region = MKCoordinateRegion(
            center: first.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1 )
        
        )
    }
    
    
     func loadEventsOnMap(events: [AnyEvent]) async {
         var results: [MapEvent] = []

         for event in events {

             if let cached = EventCoordinateCache.shared.get(eventId: event.id) {
                 results.append(
                     MapEvent(
                         id: event.id,
                         name: event.name,
                         coordinate: cached,
                         originalEvent: event
                     )
                 )
                 continue
             }

             let address = event.location
             guard !address.isEmpty else { continue }

             if let coord = await GeocodingService.shared.geocode(address: address) {
                 EventCoordinateCache.shared.set(coord, for: event.id)

                 results.append(
                     MapEvent(
                         id: event.id,
                         name: event.name,
                         coordinate: coord,
                         originalEvent: event
                     )
                 )
             }
         }

         self.mapEvents = results
     }
     
     
 }

