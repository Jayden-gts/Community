//
//  EventListVeiw.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-14.
//

import SwiftUI
import CoreData
import Foundation

struct EventListView: View {
    var body: some View {
        ScrollView {
            VStack (spacing:20){
                EventBubble(title: "Title" ,destination: AnyView(EventPageView(title: "Pekoe!"))){
                    Text("Event Description")
                }
                EventBubble(title: "Title" ,destination: AnyView(EventPageView(title: "Pekoe!"))){
                    Text("Event Description")
                }
                EventBubble(title: "Title" ,destination: AnyView(EventPageView(title: "Pekoe!"))){
                    Text("Event Description")
                }
                
            }
           
        }
    }
}

#Preview {
    EventListView()
}
