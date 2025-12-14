//
//  EventListVeiw.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-14.991746683
//

import SwiftUI
import CoreData
import Foundation

struct EventListView: View {
    @StateObject private var viewModel = EventViewModel()
    @StateObject private var locationManager = LocationManager()
    @StateObject private var store = EventStore()
    @State private var currentCity: String = ""

    var filter: EventFilter = .all

    var body: some View {
        VStack(spacing: 20) {
            if filter == .all || filter == .local {
                ForEach(store.events) { event in
                    EventBubble(
                        event: event,
                        destination: AnyView(EventPageView(event: event, eventStore: store))
                    )
                }
            }

            if filter == .all || filter == .ticketmaster {
                ForEach(viewModel.events) { event in
                    EventBubble(
                        event: event,
                        destination: AnyView(EventPageView(event: event, eventStore: store))
                    )
                }
            }
        }
        .onReceive(locationManager.$city) { city in
            guard !city.isEmpty else { return }
            currentCity = city
            viewModel.fetchEvents(city: city)
        }
        .onAppear {
            store.startListening()
        }
    }
}

