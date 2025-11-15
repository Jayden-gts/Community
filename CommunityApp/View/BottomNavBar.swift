//
//  BottomNavBar.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-14.
//

import SwiftUI

public struct BottomNavBar: View {
    public var body: some View {
        HStack(spacing: 150){
            
            
            Button(action: {
                print("Home tapped")
            }) {
                VStack {
                    Image(systemName: "house.fill")
                        .font(.system(size: 24))
                    Text("Home")
                        .font(.caption)
                }
            }
            .foregroundColor(.blue)
            
            
            
            Button(action: {
                print("Map tapped")
            }) {
                VStack {
                    Image(systemName: "map.fill")
                        .font(.system(size: 24))
                    Text("Map")
                        .font(.caption)
                }
            }
        }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            .background(
                        Color.gray.opacity(0.2)
                            .ignoresSafeArea()
                    )
    }
}
