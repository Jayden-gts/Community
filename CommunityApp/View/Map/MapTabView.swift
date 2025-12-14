//
//  MapTabView.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-11-18.
//

import SwiftUI
import MapKit

struct MapTabView : View {
    @StateObject var viewModel = MapViewModel()
    
    @StateObject private var eventStore = EventStore()
    @StateObject private var eventViewModel = EventViewModel()

    
    var body: some View {
        ZStack {
            // the main map
            
            Map(
                coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: viewModel.mapEvents
            ) { event in
                MapMarker(
                    coordinate: event.coordinate,
                    tint: .red
                )
            }
            .edgesIgnoringSafeArea(.all)
            
            
            VStack{
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.requestLocation()
                    }) {
                        Image(systemName: "location.fill")
                            .padding()
                            .background(Color.blue.opacity(0.8))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .padding()
                    }
                }
            }
        }
        .onAppear {
                    viewModel.checkAuthorizationStatus()
                    
                    eventStore.startListening()
                    
                    eventViewModel.fetchEvents(city: "Toronto") // or your detected city
                }
                .onChange(of: eventStore.events) { _ in
                    reloadMapPins()
                }
                .onChange(of: eventViewModel.events) { _ in
                    reloadMapPins()
                }
            }
            
            private func reloadMapPins() {
                Task {
                    let allEvents: [any AnyEvent] =
                    eventStore.events + eventViewModel.events
                    
                    await viewModel.loadEventsOnMap(events: allEvents)
                }
            }
        }
        
