//
//  ContentView.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-14.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        VStack (spacing: 0){
            ScrollView {
                EventListView()
            }.padding(.horizontal)
            
        }.navigationTitle(Text("Events"))
            .foregroundStyle(Color(red: 50/255, green: 100/255, blue: 30/255))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    
                }
            }
    }
}

#Preview {
    MainTabView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
