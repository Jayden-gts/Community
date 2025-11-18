//
//  LocalEventModel.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-16.
//

import Foundation
import PhotosUI

struct LocalEvent: Identifiable, Codable {
    var id: String
    var ownerId: String
    var name: String
    var date: Date
    var imageUrl: String?
    var location: String
    var description: String
    var ageGroup: String
    var language: String
}
