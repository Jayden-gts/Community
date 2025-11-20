//
//  AnyEvent.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-19.
//

import Foundation

protocol AnyEvent: Identifiable {
    var id: String { get }
    var name: String { get }
    var imageUrl: String? { get }
    var dateString: String { get }
    var timeString: String { get }
    var location: String { get }
    var genreString: String { get }
    var segmentString: String { get }
}

extension Event: AnyEvent {
    var imageUrl: String? { images?.first?.url }
    var dateString: String { dates?.start?.localDate ?? "No date available" }
    var timeString: String { dates?.start?.localTime ?? "No time available" }
    var location: String { "" }
    var genreString: String { classifications?.first?.genre?.name ?? "" }
    var segmentString: String { classifications?.first?.segment?.name ?? "" }
    
}

extension LocalEvent: AnyEvent {
    var dateString: String {
        DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
    }
    var timeString: String {
        DateFormatter.localizedString(from: time, dateStyle: .none, timeStyle: .short)
    }
    var locationString: String { location }
    
    var genreString: String { ageGroup.joined(separator: ", ") }
    var segmentString: String { language.joined(separator: ", ") }
}
