//
//  ContentView.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-14.991746683
//

import SwiftUI
import CoreData
import Foundation

enum EventFilter: String, CaseIterable, Identifiable {
    case all = "All Events"
    case local = "Local Events"
    case ticketmaster = "Ticketmaster Events"

    var id: String { self.rawValue }
}

    struct ContentView: View {
        @Environment(\.managedObjectContext) private var viewContext
        @EnvironmentObject var session: SessionManager

        @State private var showFilterSheet = false
        @State private var selectedFilter: EventFilter = .all

        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    Text("Commun").font(.system(size: 30)) +
                    Text("IT")
                        .foregroundStyle(Color(red: 50/255, green: 100/255, blue: 30/255))
                        .font(.system(size: 30, weight: .bold, design: .default))
                }
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 30, trailing: 0))
                
                ScrollView {
                    EventListView(filter: selectedFilter)
                }
                .padding(.horizontal)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Top-left filter button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showFilterSheet.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title2)
                            .foregroundColor(Color(red: 50/255, green: 100/255, blue: 30/255))
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileDataView().environmentObject(session)) {
                        Image(systemName: "person.circle.fill")
                            .font(.title)
                            .foregroundColor(Color(red: 50/255, green: 100/255, blue: 30/255))
                    }
                }
            }
            .sheet(isPresented: $showFilterSheet) {
                FilterSheet(selectedFilter: $selectedFilter)
            }
        }
    }

    struct FilterSheet: View {
        @Binding var selectedFilter: EventFilter

        var body: some View {
            NavigationStack {
                List {
                    ForEach(EventFilter.allCases) { filter in
                        HStack {
                            Text(filter.rawValue)
                            Spacer()
                            if filter == selectedFilter {
                                Image(systemName: "checkmark")
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedFilter = filter
                        }
                    }
                }
                .navigationTitle("Filter Events")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                        }
                    }
                }
            }
        }
    }
