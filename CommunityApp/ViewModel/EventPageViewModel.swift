//
//  EventPageViewModel.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-12-13.
//

import Foundation

@MainActor
class EventPageViewModel: ObservableObject {
    @Published var isDeleting = false
    private let eventStore: EventStore

    init(eventStore: EventStore) {
        self.eventStore = eventStore
    }

    func delete(event: LocalEvent) async {
        isDeleting = true
        await eventStore.deleteEvent(event)
        isDeleting = false
    }
}
