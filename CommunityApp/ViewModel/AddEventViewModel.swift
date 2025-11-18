//
//  AddEventViewModel.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-16.
//

import Foundation
import _PhotosUI_SwiftUI
import FirebaseStorage

@MainActor
class AddEventViewModel: ObservableObject {
    @Published var eventName: String = ""
    @Published  var eventDescription: String = ""
    @Published  var eventDate: Date = Date()
    @Published  var eventTime: Date = Date()
    @Published  var eventLocation: String = ""
    @Published  var eventImage: PhotosPickerItem?
    @Published  var ageGroup: String = "All Ages"
    @Published  var language: String = "English"
    @Published var eventImageData: Data?
    
    
    @Published var isSaving = false
    @Published var errorMessage: String?
    
    var canSave : Bool {
        !eventName.isEmpty &&
        eventImage != nil &&
        !eventDescription.isEmpty &&
        !eventLocation.isEmpty &&
        !ageGroup.isEmpty &&
        !language.isEmpty &&
        !eventTime.description.isEmpty &&
        eventDate >= Date()
    }
    
    private let eventRepo = EventRepository()
    
    func saveEvent(ownerId: String) async {
        isSaving = true
        do{
            let imageUrlString = try await upload(data: eventImageData)
            
            
            let newEvent = LocalEvent(
                id: UUID().uuidString, ownerId: ownerId, name: eventName, date: eventDate, imageUrl: imageUrlString, location: eventLocation, description: eventDescription, ageGroup: ageGroup, language: language,
            )
            
            
            try await eventRepo.createEvent(newEvent)
            isSaving = false
        } catch {
            self.errorMessage = error.localizedDescription
            isSaving = false
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
    
    func loadImage() async {
        
        if let item = eventImage {
                eventImageData = try? await item.loadTransferable(type: Data.self)
        }
    }
    
}
