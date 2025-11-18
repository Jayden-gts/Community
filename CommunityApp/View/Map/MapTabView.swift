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
    
    var body: some View {
        ZStack {
            // the main map
            Map(coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: viewModel.userLocation != nil ? [UserLocation(id: UUID(), coordinate:viewModel.userLocation!)] : []) {
                location in MapMarker(coordinate: location.coordinate, tint: Color.red)
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
        }
    }
}

struct UserLocation: Identifiable {
    let id: UUID
    let coordinate: CLLocationCoordinate2D
}

struct MapTabView_Previews: PreviewProvider {
    static var previews: some View {
        MapTabView()
    }
}
