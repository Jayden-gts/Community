//
//  LocalEventModel.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-16.991746683
//

import Foundation

struct LocalEvent: Identifiable, Codable, Equatable {
    var id: String
    var ownerId: String
    var name: String
    var date: Date
    var imageUrl: String?
    var location: String
    var description: String
    var ageGroup: [String]
    var language: [String]
    var time: Date
    var city: String
    var latitude: Double?
    var longitude: Double?
}
