//
//  AddEventViewModel.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-16.
//

import Foundation
import _PhotosUI_SwiftUI
import FirebaseStorage
import MapKit

@MainActor
class AddEventViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchResults: [MKLocalSearchCompletion] = []
    @Published var eventName: String = ""
    @Published  var eventDescription: String = ""
    @Published  var eventDate: Date = Date()
    @Published  var eventTime: Date = Date()
    @Published  var eventLocation: String = ""
    @Published  var ageGroup: [String] = []
    @Published  var language: [String] = []
    @Published var eventCity: String = ""

    @Published var isSaving = false
    @Published var errorMessage: String?
    
    private var searchCompleter = MKLocalSearchCompleter()
    
    var canSave : Bool {

        !eventName.isEmpty &&
        !eventDescription.isEmpty &&
        !eventLocation.isEmpty &&
        !ageGroup.isEmpty &&
        !language.isEmpty &&
        !eventTime.description.isEmpty &&
        eventDate >= Date()
    }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
    }
    
    func updateRegion(lat: Double, lon: Double) {
        searchCompleter.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
    }
    
    func updateSearch(query: String){
        if query.isEmpty {
            searchResults = []
            print("No results")
            return
        }
        print("Starting search for: \(query)")
        searchCompleter.queryFragment = query
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        Task { @MainActor in
            self.searchResults = completer.results
            print("Search Completer Success! Results found: \(self.searchResults.count)")
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Search Completer failed with error: \(error.localizedDescription)")
    }
    
    private let eventRepo = EventRepository()
    
    func setInitialSearchRegion(lat: Double, lon: Double) {
        let coordinate: CLLocationCoordinate2D
            if lat.isZero && lon.isZero || lat.isNaN || lon.isNaN {
            coordinate = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)
            print("Using fallback search region.")
        } else {
            coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            print("Using user location for search region: (\(lat), \(lon))")
        }
        
        searchCompleter.region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
    }
    
    
    
    func saveEvent(ownerId: String) async -> LocalEvent? {
        isSaving = true
        do{
            let newEvent = LocalEvent(
                id: UUID().uuidString,
                ownerId: ownerId,
                name: eventName,
                date: eventDate,
                imageUrl: nil,
                location: eventLocation,
                description: eventDescription,
                ageGroup: ageGroup,
                language: language,
                time: eventTime,
                city: eventCity
                
            )
            
            
            try await eventRepo.createEvent(newEvent)
            isSaving = false
            return newEvent
        } catch {
            print("Error creating event:", error)
            self.errorMessage = error.localizedDescription
            isSaving = false
            return nil
        }
    }
    
    func upload(data: Data?) async throws -> String {
        guard let data = data else {
            throw URLError(.badServerResponse)
            
        }
        
        let imageId = UUID().uuidString
        let storageRef = Storage.storage().reference().child("eventImages/\(imageId).jpg")
        
        let _ = try await storageRef.putDataAsync(data)
        
        let url = try await storageRef.downloadURL()
        return url.absoluteString
    }

}


