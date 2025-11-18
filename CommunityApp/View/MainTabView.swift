//
//  MainTabView.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-14.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        
        TabView {
            NavigationView {
                ContentView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            }
            
            NavigationView {
                AddEventView() //PlaceHolder for when MapView is developed.
            }
            .tabItem {
                VStack {
                    Image(systemName: "plus")
                    Text("New Event")
                }
            }
            NavigationView {
                MapTabView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "map.fill")
                    Text("Event Map")
                }
            }
        }
        
        
        
    }
}
