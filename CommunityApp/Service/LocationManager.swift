//
//  LocationManager.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-15.
//

import CoreLocation
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager = CLLocationManager()
    @Published var lat: Double = 0.0
    @Published var lon: Double = 0.0
    @Published var city: String = ""
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        //manager.startUpdatingLocation()
    }
    
    
    

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            
            manager.startUpdatingLocation()
        case .denied, .restricted:
            
            print("Location access denied or restricted.")
            DispatchQueue.main.async {
                self.city = "Unknown City"
            }
        case .notDetermined:
            
            manager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        DispatchQueue.main.async {
            self.lat = location.coordinate.latitude
            self.lon = location.coordinate.longitude
        }
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, _ in
            if let placemark = placemarks?.first {
                DispatchQueue.main.async {
                    self.city = placemark.locality ?? "Unknown City"
                    print("LocationManager published city:", self.city)
                }
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Location manager failed with error: \(error.localizedDescription)")
        }
}
