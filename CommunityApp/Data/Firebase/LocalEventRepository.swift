//
//  LocalEventRepository.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-16. 991746683
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
    
    func deleteEvent(_ event: LocalEvent) async throws {
            try await db.collection("events").document(event.id).delete()
        }
    
    func listenForEvents() -> AsyncStream<[LocalEvent]> {
        AsyncStream { continuation in
            db.collection("events")
                .addSnapshotListener { snapshot, error in
                    if let error = error {
                        print("Firestore listener error:", error.localizedDescription)
                        return
                    }
                    guard let snapshot = snapshot else { return }
                    let events = snapshot.documents.compactMap { try? $0.data(as: LocalEvent.self) }
                    print("Firestore snapshot count:", events.count)
                    continuation.yield(events)
                }
        }
    }
}
