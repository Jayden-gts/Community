//
//  AddEventView.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-16.991746683
//

import SwiftUI
import Foundation
import PhotosUI
import MapKit


struct AddEventView: View {
    @StateObject private var vm = AddEventViewModel()
    @StateObject var locationManager = LocationManager()
    @State private var displayedImageData: Data?
    @ObservedObject var store: EventStore
    @FocusState private var isFocused: Bool
    @State private var showAlert = false
    
    let languageOptions = ["English", "French", "Spanish", "Punjabi", "Arabic", "Other/All"]
    let ageOptions = ["Infants", "Children", "Teens", "Adults", "Seniors", "All Ages"]
    @State private var selectedAgeOptions: Set<String> = []
    @State private var selectedLanguageOptions: Set<String> = []
    let currentUserId = "currentUserId" //fix later
    
    var body: some View {
        Form{
            TextField("Event Name", text: $vm.eventName)
            VStack{
                TextField("Event Location", text: $vm.eventLocation)
                    .onChange(of: vm.eventLocation) { newValue in
                        vm.updateSearch(query: newValue)
                    }
                    
                    .padding(.vertical, 4)
                    .focused($isFocused)
                
                if !vm.searchResults.isEmpty && isFocused {
                    ScrollView{
                        VStack(alignment: .leading, spacing: 0){
                            ForEach(vm.searchResults, id: \.self) {result in
                                Button {
                                    vm.eventLocation = result.title + ", " + result.subtitle
                                    vm.searchResults = []
                                    isFocused = false
                                    
                                    let subtitleParts = result.subtitle.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                                            if subtitleParts.count >= 1 {
                                                vm.eventCity = String(subtitleParts[0])
                                            } else {
                                                vm.eventCity = ""
                                            }
                                } label : {
                                    VStack(alignment: .leading) {
                                        Text(result.title)
                                        if !result.subtitle.isEmpty {
                                            Text(result.subtitle).foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxHeight: 200)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    .zIndex(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            DatePicker("Date", selection: $vm.eventDate, displayedComponents: [.date, .hourAndMinute])
            Section("Age Groups"){
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12){
                    ForEach(ageOptions, id: \.self) {option in
                        MultipleSelectionRow(title: option , isSelected: selectedAgeOptions.contains(option)){
                            if selectedAgeOptions.contains(option) {
                                selectedAgeOptions.remove(option)
                            }else{
                                selectedAgeOptions.insert(option)
                            }
                        }
                    }
                }
            }
            Section("Language"){
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12){
                    ForEach(languageOptions, id: \.self) {option in
                        MultipleSelectionRow(title: option , isSelected: selectedLanguageOptions.contains(option)){
                            if selectedLanguageOptions.contains(option) {
                                selectedLanguageOptions.remove(option)
                            }else{
                                selectedLanguageOptions.insert(option)
                            }
                        }
                    }
                }
            }
            Section("Event Image") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        
                        let imageNames = ["allAges", "babies", "children", "teens", "adults", "oldPeople", "localeventpekoe"]
                        
                        ForEach(imageNames, id: \.self) { name in
                            Image(name)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(vm.selectedImageName == name ? Color.blue : Color.clear, lineWidth: 3)
                                )
                                .onTapGesture {
                                    vm.selectedImageName = name
                                }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            
            
            TextField("Event Description", text: $vm.eventDescription, axis: .vertical)
                .lineLimit(5...10)
            
            Button("Save"){
                vm.ageGroup = Array(selectedAgeOptions)
                    vm.language = Array(selectedLanguageOptions)
                    vm.eventTime = vm.eventDate
                Task {
                    if let newEvent = await vm.saveEvent(ownerId: currentUserId){
                        await store.addEvent(newEvent)
                        print("Saved event:", newEvent.name)
                        vm.eventName = ""
                        vm.eventLocation = ""
                        vm.eventDescription = ""
                        vm.eventDate = Date()
                        selectedAgeOptions.removeAll()
                        selectedLanguageOptions.removeAll()
                        displayedImageData = nil
                        showAlert = true
                    }else {
                        print("Failed to save event")
                    }
                }
            }
        }
        .alert("Event Posted!", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Your event has been successfully added.")
        }
        .onAppear {
                vm.setInitialSearchRegion(lat: locationManager.lat, lon: locationManager.lon)
            }
    }
}




