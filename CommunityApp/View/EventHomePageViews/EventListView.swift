//
//  EventListVeiw.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-14.991746683
//

import SwiftUI
import CoreData
import Foundation
//
//struct EventListView: View {
//    @StateObject private var viewModel = EventViewModel()
//    @StateObject private var locationManager = LocationManager()
//    @StateObject private var store = EventStore()
//    @State private var currentCity: String = ""
//    var body: some View {
//        ScrollView {
//            VStack (spacing:20){
//
//                ForEach(store.events) { event in
//                    EventBubble(
//                        event: event,
//                        destination: AnyView(EventPageView(event: event, eventStore: store))
//                    )
//                }
//
//                ForEach(viewModel.events) { event in
//                    EventBubble(
//                        event: event,
//                        destination: AnyView(EventPageView(event: event, eventStore: store))
//                    )
//                }
//
//            }
//        }
//        .onReceive(locationManager.$city){ city in
//            guard !city.isEmpty else { return }
//            currentCity = city
//            viewModel.fetchEvents(city: city)
//            
//        }
//        .onAppear{
//            store.startListening()
//            
//        }
//    }
//}
//
//#Preview {
//    EventListView()
//}
//


// MARK: - EventListView
struct EventListView: View {
    @StateObject private var viewModel = EventViewModel()
    @StateObject private var locationManager = LocationManager()
    @StateObject private var store = EventStore()
    @State private var currentCity: String = ""

    var filter: EventFilter = .all  // use shared EventFilter

    var body: some View {
        VStack(spacing: 20) {
            // Local events
            if filter == .all || filter == .local {
                ForEach(store.events) { event in
                    EventBubble(
                        event: event,
                        destination: AnyView(EventPageView(event: event, eventStore: store))
                    )
                }
            }

            // Ticketmaster events
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

