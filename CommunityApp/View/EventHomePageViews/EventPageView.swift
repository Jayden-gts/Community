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
    let title: String
    
    
    
    init(title: String){
        self.title = title
        
    }
    var body: some View {
            VStack() {
                
                Text(title).padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                
                    Image("pekoe")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 350, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.").padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
                
                Text("Event Details").font(.headline).padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 0))
                Text("Date: ")
                Text("Time: ")
                Text("Age range: ")
                Text("Cost: ")
                Text("Address: ")
                
                Link("Check out the site for more details!", destination: URL(string: "https://www.apple.com")!).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    
            }.frame(minWidth: 380,maxWidth: 380,minHeight: 500 ,alignment: .center)
            .background(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth:1))
            .background(Color.gray.opacity(0.2))
            .cornerRadius(15)
            .navigationTitle(Text("Community App"))
                .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EventPageView(title: "Event")
}
