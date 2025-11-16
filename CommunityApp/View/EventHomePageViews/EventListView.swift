//
//  EventListVeiw.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-14.
//

import SwiftUI
import CoreData
import Foundation

struct EventListView: View {
    @StateObject private var viewModel = EventViewModel()
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        ScrollView {
            VStack (spacing:20){
                ForEach(viewModel.events) { event in
                    EventBubble(
                        event: event,
                        destination: AnyView(EventPageView(title: event.name))
                    )
                }
            }
        }
        .onReceive(locationManager.$city){ city in
            guard !city.isEmpty else { return }
            viewModel.fetchEvents(city: city)
        }
//        .onAppear{
//            viewModel.fetchEvents(city: "Toronto")
//}
    }
}

#Preview {
    EventListView()
}
