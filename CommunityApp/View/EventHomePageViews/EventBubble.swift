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
    let event: any AnyEvent
    let destination: AnyView
        
    var body: some View {
        NavigationLink(destination: destination){
            VStack(spacing: 20) {
                
                Text(event.name)
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                HStack{
                    if !event.segmentString.isEmpty {
                        Text(event.segmentString).bold()
                    }
                    if !event.genreString.isEmpty {
                        Text(": \(event.genreString)")
                    }
                    
                }
                Group{
                if let imageStr = event.imageUrl, !imageStr.isEmpty {
                    if imageStr.starts(with: "http") {
                        AsyncImage(url: URL(string: imageStr)) { image in
                            image.resizable().aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray.opacity(0.2)
                        }
                    } else {
                        Image(imageStr)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                } else {
                    Image("localeventpekoe")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
                .frame(width: 350, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                HStack{
                    Text("Date: ").fontWeight(.bold)
                    Text(event.dateString + ",")
                    Text(event.timeString)
                }.padding(EdgeInsets(top: 0, leading: 5, bottom: 30, trailing: 0))
            }.frame(minWidth: 380,minHeight: 330, alignment: .center)
                .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color(red: 50/255, green: 100/255, blue: 30/255), lineWidth: 5))
                .background(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray, lineWidth:1))
                .background(Color(.systemGray6))
                .cornerRadius(15)
        }.foregroundStyle(Color(red: 50/255, green: 100/255, blue: 30/255))
    }
}

#Preview {
    ContentView()
}
