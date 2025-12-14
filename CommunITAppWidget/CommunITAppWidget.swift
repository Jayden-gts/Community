
//
//  CommunITAppWidget.swift
//  CommunITAppWidget
//
//  Created by Laiba Ahmed on 2025-12-13. 991691793
//
//

import WidgetKit
import SwiftUI

// MARK: - Timeline Provider
struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), events: sampleEvents(count: 3), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), events: sampleEvents(count: configuration.numberOfEvents), configuration: configuration)
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let sharedDefaults = UserDefaults(suiteName: "group.com.CommunityApp")
        var events: [WidgetEvent] = []
        if let data = sharedDefaults?.data(forKey: "upcomingEvents"),
           let savedEvents = try? JSONDecoder().decode([WidgetEvent].self, from: data) {
            events = savedEvents
        } else {
            // fallback to sample events
            events = (1...configuration.numberOfEvents).map {
                WidgetEvent(id: "\($0)", name: "Sample Event \($0)", date: Date().addingTimeInterval(Double($0)*3600), imageName: "event\($0)", location: "Location \($0)" )
            }
        }
        let entry = SimpleEntry(date: Date(), events: events, configuration: configuration)
        return Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(30*60)))
    }

    private func sampleEvents(count: Int) -> [WidgetEvent] {
        (1...count).map {
            WidgetEvent(id: "\($0)", name: "Sample Event \($0)", date: Date().addingTimeInterval(Double($0) * 3600), imageName: "event\($0)", location: "Location \($0)" )
        }
    }
}

// MARK: - Timeline Entry
struct SimpleEntry: TimelineEntry {
    let date: Date
    let events: [WidgetEvent]
    let configuration: ConfigurationAppIntent
}



// MARK: - Widget View
struct CommunITAppWidgetEntryView: View {
    var entry: SimpleEntry

    var body: some View {
        ZStack {
            Color(red: 230/255, green: 245/255, blue: 230/255)
                .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Upcoming Events")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color(red: 50/255, green: 100/255, blue: 30/255))
                
                // Display only 2 events
                ForEach(entry.events.prefix(2)) { event in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(event.name)
                            .font(.headline)
                            .lineLimit(1)
                            .foregroundColor(Color(red: 50/255, green: 100/255, blue: 30/255))
                        
                        Text(event.date, style: .time)
                            .font(.caption)
                            .foregroundColor(Color(red: 50/255, green: 100/255, blue: 30/255).opacity(0.8))
                        
                    
                        Divider()
                            .background(Color(red: 50/255, green: 100/255, blue: 30/255).opacity(0.5))
                    }
                }
                
                Spacer() // push content to top
            }
            .padding()
        }
        .padding(4) // padding around entire widget
    }
}




// MARK: - Widget Configuration
struct CommunITAppWidget: Widget {
    let kind: String = "CommunITAppWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            CommunITAppWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Upcoming Events")
        .description("Shows your next events.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Preview
#Preview(as: .systemMedium) {
    CommunITAppWidget()
} timeline: {
    SimpleEntry(
        date: .now,
        events: [
            WidgetEvent(id: "1", name: "Event 1", date: .now, imageName: "event1", location: "Community Hall"),
            WidgetEvent(id: "2", name: "Event 2", date: .now.addingTimeInterval(3600), imageName: "event2", location: "Library Room 2"),
            WidgetEvent(id: "3", name: "Event 3", date: .now.addingTimeInterval(7200), imageName: "event3", location: "Gymnasium")
        ],
        configuration: ConfigurationAppIntent()
    )
}
