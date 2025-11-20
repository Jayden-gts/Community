//
//  EventStore.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-19.
//

import Foundation

@MainActor
class EventStore: ObservableObject {
    @Published var events: [LocalEvent] = []
    private let repository = EventRepository()
    
    func startListening() {
        print("Starting listener...")
        Task{
            for await events in repository.listenForEvents() {
                self.events = events
            }
        }
    }
    
    func addEvent(_ event: LocalEvent) async {
        events.insert(event, at: 0)
        do {
                try await repository.createEvent(event)
            } catch {
                print("Failed to save event:", error)
                events.removeAll { $0.id == event.id }
            }
    }
    
}

