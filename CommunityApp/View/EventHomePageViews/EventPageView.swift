//
//  EventPageView.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-14.
//

import SwiftUI
import CoreData
import Foundation

struct EventPageView: View {
    let event: any AnyEvent
    
    
    
    
    var body: some View {
        VStack(alignment: .center) {
                
                Text(event.name).padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                
                
                if event is LocalEvent {
                    Image("localeventpekoe")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 350, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
                if event is Event {
                    if let urlString = event.imageUrl,
                       let url = URL(string: urlString) {
                        
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: 350, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    
                }
                    
                if event is LocalEvent {
                    Text("\(event.eventDescription ?? "No description")").padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))

            }
                
                Text("Event Details").font(.headline).padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 0))
                Text("Date: \(event.dateString)")
                Text("Time: \(event.timeString)")
                if event is LocalEvent {
                    Text("Age Range: \(event.genreString)")
                    Text("Language(s): \(event.segmentString)")
                } else {
                    Text("Subgenre: \(event.genreString)")
                    Text("Genre: \(event.segmentString)")
                }
                Text("Address: \(event.location)").padding(.bottom, event is LocalEvent ? 20 : 0)
            
            if event is Event {
                Link("Check out the site for more details!", destination: URL(string: event.url ?? "")!).padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            }
                
                    
            }.frame(minWidth: 380,maxWidth: 380,minHeight: 500 ,alignment: .center)
            .background(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth:1))
            .background(Color.gray.opacity(0.2))
            .cornerRadius(15)
            .navigationTitle(Text("Community App"))
                .navigationBarTitleDisplayMode(.inline)
                
    }
}
