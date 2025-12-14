//
//  ProfileDataView.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-12-13. 991691793
//

import SwiftUI

struct ProfileDataView: View {
    @EnvironmentObject var session: SessionManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 30) {
            // Profile header
            VStack(spacing: 10) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(red: 50/255, green: 100/255, blue: 30/255))
                
                Text("Profile")
                    .font(.largeTitle)
                    .bold()
            }
            
            VStack(alignment: .leading, spacing: 15) {

                HStack {
                    Text("Email:")
                        .font(.headline)
                    Spacer()
                    Text(session.currentUserEmail)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(radius: 2)
            .padding(.horizontal)
            
            Button(action: {
                session.logout()
                dismiss()  
            }) {
                Text("Log Out")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.top, 30)
    }
}

#Preview {
    ProfileDataView()
        .environmentObject(SessionManager())
}
