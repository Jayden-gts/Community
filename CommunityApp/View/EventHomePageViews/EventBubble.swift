//
//  Event.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-14.
//

import SwiftUI
import CoreData
import Foundation

struct EventBubble: View {
    let event: Event
    let destination: AnyView
    
    init(event: Event, destination: AnyView){
        self.event = event
        self.destination = destination
    }
    
    
    var body: some View {
        NavigationLink(destination: destination){
            VStack(spacing: 30) {
                
                Text(event.name).padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                HStack{
                    Text(event.classifications?.first?.segment?.name ?? "")
                    Text(": ")
                    Text(event.classifications?.first?.genre?.name ?? "")
                    
                }
                
                if let imageUrl = event.images?.first?.url {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                        .frame(width: 350, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                HStack{
                    Text("Date: ").fontWeight(.bold)
                    Text(event.dates?.start?.localDate ?? "No date available")
                    Text(",")
                    Text(event.dates?.start?.localTime ?? "No time available")
                }.padding(EdgeInsets(top: 0, leading: 5, bottom: 30, trailing: 0))
                
                
                
            }.frame(minWidth: 380,minHeight: 330, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray, lineWidth:1))
                .background(Color.gray.opacity(0.2))
                .cornerRadius(15)
            
        }
        
    }
}

#Preview {
    ContentView()
}
