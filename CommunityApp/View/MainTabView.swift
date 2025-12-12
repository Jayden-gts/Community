//
//  MainTabView.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-14.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var store = EventStore()
    init() {
        let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.systemBackground
            
            // Selected icon + text color
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(
                red: 50/255,
                green: 100/255,
                blue: 30/255,
                alpha: 1.0
            )
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor(
                    red: 50/255,
                    green: 100/255,
                    blue: 30/255,
                    alpha: 1.0
                )
            ]
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
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
                AddEventView(store: store)
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
