//
//  AppIntent.swift
//  CommunITAppWidget
//
//  Created by Laiba Ahmed on 2025-12-13. 991691793
//


import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Upcoming Events Widget" }
    static var description: IntentDescription {
        "Choose how many upcoming events to show."
    }
    @Parameter(title: "Number of Events", default: 3)
    var numberOfEvents: Int
}
