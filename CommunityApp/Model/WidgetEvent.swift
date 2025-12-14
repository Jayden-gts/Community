//
//  WidgetEvent.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-12-13. 991691793
//

import Foundation

struct WidgetEvent: Identifiable, Codable {
    let id: String
    let name: String
    let date: Date
    let imageName: String?
    
    let location: String?   


}
