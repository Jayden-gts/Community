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
    var url: String? { get }
}

extension Event: AnyEvent {
    var eventUrl: String? { self.url }
    var imageUrl: String? { images?.first?.url }
    var dateString: String { dates?.start?.localDate ?? "No date available" }
    var timeString: String { dates?.start?.localTime ?? "No time available" }

    var location: String {
        guard let venue = _embedded?.venues.first else { return "" }

        let line = venue.address?.line1 ?? ""
        let city = venue.city?.name ?? ""
        let state = venue.state?.name ?? ""
        let country = venue.country?.name ?? ""

        return [line, city, state, country].compactMap { $0.isEmpty ? nil : $0 }
            .joined(separator: ", ")
    }

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
    var url: String? { nil }
}
