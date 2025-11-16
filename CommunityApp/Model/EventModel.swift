//
//  EventModel.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-15.
//

struct TicketMasterResponse: Decodable {
    let _embedded: EmbeddedEvents?
}

struct EmbeddedEvents: Decodable {
    let events: [Event]
}

struct Event: Decodable, Identifiable {
    let id: String
    let name: String
    let url: String?
    let info: String?
    let classifications: [EventClassification]?
    let dates: EventDates?
    let images: [EventImage]?
    
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

