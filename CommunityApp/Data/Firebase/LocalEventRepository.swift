//
//  LocalEventRepository.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-16.
//

import Foundation
import FirebaseFirestore


final class EventRepository {
    private let db = Firestore.firestore()
    
    func createEvent(_ event: LocalEvent) async throws {
        try db.collection("events").document(event.id).setData(from: event)
    }
    
    func fetchEvents() async throws -> [LocalEvent] {
        let snapshot = try await db.collection("events").getDocuments()
        return snapshot.documents.compactMap{doc in
            try? doc.data(as: LocalEvent.self)
        }
    }
}
