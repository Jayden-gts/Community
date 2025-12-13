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
            HStack{
                Text("Commun").font(.system(size: 30)) + Text("IT").foregroundStyle(Color(red: 50/255, green: 100/255, blue: 30/255)).font(.system(size: 30, weight: .bold, design: .default))
            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 30, trailing: 0))
            
            ScrollView {
                EventListView()
            }.padding(.horizontal)
            
        }.navigationTitle(Text(""))
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
