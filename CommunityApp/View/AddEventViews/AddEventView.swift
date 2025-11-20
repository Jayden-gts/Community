//
//  AddEventView.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-16.
//

import SwiftUI
import Foundation
import PhotosUI


struct AddEventView: View {
    @StateObject private var vm = AddEventViewModel()
    @State private var displayedImageData: Data?
    @ObservedObject var store: EventStore

    let languageOptions = ["English", "French", "Spanish", "Punjabi", "Arabic", "Other/All"]
    let ageOptions = ["Infants", "Children", "Teens", "Adults", "Seniors", "All Ages"]
        @State private var selectedAgeOptions: Set<String> = []
        @State private var selectedLanguageOptions: Set<String> = []
    let currentUserId = "currentUserId" //fix later
    var body: some View {
        Form{
            TextField("Event Name", text: $vm.eventName)
            
            TextField("Event Location", text: $vm.eventLocation)
            
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
            
            
//            PhotosPicker(
//                selection: $vm.eventImage,
//                matching: .images,
//                photoLibrary: .shared()){
//                    VStack{
//                        if let data = vm.eventImageData,
//                           let uiImage = UIImage(data: data) {
//                            Image(uiImage: uiImage)
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 350, height: 300)
//                                .clipShape(RoundedRectangle(cornerRadius: 15))
//                                .clipped()
//                        } else {
//                            ZStack{
//                                RoundedRectangle(cornerRadius: 15)
//                                    .fill(Color.gray.opacity(0.2))
//                                    .frame(height: 300)
//                                VStack{
//                                    Text("+")
//                                    Text("Select image for event")
//
//                                }
//                                                            }
//                            }
//                        }
//                }.onChange(of: vm.eventImage) { newValue in
//                    Task {
//                        guard let item = newValue else { return }
//                        do {
//                            if let data = try await item.loadTransferable(type: Data.self) {
//                                await MainActor.run {
//                                    vm.eventImageData = data
//                                    displayedImageData = data
//                                    print("Loaded image data size: \(data.count)")
//                                }
//                            } else {
//                                print("Failed to load image data: nil")
//                            }
//                        } catch {
//                            print("Error loading image: \(error)")
//                        }
//                    }
//                }
                

            
            
            TextField("Event Description", text: $vm.eventDescription, axis: .vertical)
                .lineLimit(5...10)
            
            Button("Save"){
                Task {
//                    print("vm.eventImageData size before save: \(vm.eventImageData?.count ?? 0)")

                    if let newEvent = await vm.saveEvent(ownerId: currentUserId){
                        await store.addEvent(newEvent)
                        print("Saved event:", newEvent.name)
                    }else {
                        print("Failed to save event")
                    }
                }
            }
        }.navigationTitle(Text("Add New Event"))
    }
}

