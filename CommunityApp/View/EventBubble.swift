//
//  Event.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-14.
//

import SwiftUI
import CoreData
import Foundation

struct EventBubble<Content: View>: View {
    let title: String
    let content: Content
    
    
    init(title: String, @ViewBuilder content: () -> Content ){
        self.title = title
        self.content = content()
    }
    
    
    var body: some View {
            VStack(spacing: 30) {
                
                Text(title).padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                
                    Image("pekoe")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 350, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    content.multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 30, trailing: 0))
                
    
            }.frame(minWidth: 380,minHeight: 330, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth:1))
            .background(Color.gray.opacity(0.3))
            .cornerRadius(15)
            
        
        
    }
}

#Preview {
    ContentView()
}
