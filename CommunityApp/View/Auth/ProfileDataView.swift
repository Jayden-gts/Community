//
//  ProfileDataView.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-12-13.
//

import SwiftUI

struct ProfileDataView: View {
    @EnvironmentObject var session: SessionManager
        var body: some View {
            VStack(spacing: 20) {
                Text("Logged in as:")
                    .font(.headline)
                Text(session.currentUserEmail)
                    .font(.title2)
                    .bold()
                
                Button("Log Out") {
                    session.logout()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(10)
            }
            .padding()
            .navigationTitle("Profile")
        }
}
