//
//  CommunityAppApp.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-14.
//

import SwiftUI

@main
struct CommunityAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainTabView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
