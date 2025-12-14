//
//  RootView.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-12-13. 991691793
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var session: SessionManager
    @State private var showMainTab = false

    
    var body: some View {
        ZStack {
            if session.isLoggedIn {
                MainTabView()
            } else {
                LoginView()

            }
        }
    }
}
