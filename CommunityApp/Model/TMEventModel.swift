//
//  EventModel.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-15.991746683
//

struct TicketMasterResponse: Decodable {
    let _embedded: EmbeddedEvents?
}

struct EmbeddedEvents: Decodable {
    let events: [Event]
    
}
struct EventEmbedded: Decodable {
    let venues: [Venue]
    
}

struct Event: Decodable, Identifiable, Equatable {
    let id: String
    let name: String
    let url: String?
    let info: String?
    let classifications: [EventClassification]?
    let dates: EventDates?
    let images: [EventImage]?
    let _embedded: EventEmbedded?
    
    static func == (lhs: Event, rhs: Event) -> Bool {
            lhs.id == rhs.id
        }
}

struct Venue: Decodable {
    let name: String?
    let address: VenueAddress?
    let city: VenueCity?
    let state: VenueState?
    let country: VenueCountry?
}

struct VenueAddress: Decodable { let line1: String? }
struct VenueCity: Decodable { let name: String? }
struct VenueState: Decodable { let name: String?; let stateCode: String? }
struct VenueCountry: Decodable { let name: String? }

struct location: Decodable {
    let longitude: String?
    let latitude: String?
}

struct EventDates: Decodable {
    let start: EventStartDates?
}

struct EventImage: Decodable {
    let url: String?
}

struct EventStartDates: Decodable {
    let localDate: String?
    let localTime: String?
}

struct EventClassification: Decodable {
    let genre: EventGenre?
    let segment: EventSegment?
}

struct EventGenre: Decodable {
    let name: String?
}

struct EventSegment: Decodable {
    let name: String?
}

