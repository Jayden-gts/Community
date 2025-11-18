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

    let options = ["English", "French", "Spanish", "Punjabi", "Arabic", "Other/All"]
        @State private var selectedOptions: Set<String> = []
    let currentUserId = "currentUserId" //fix later
    var body: some View {
        Form{
            TextField("Event Name", text: $vm.eventName)
            
            TextField("Event Location", text: $vm.eventLocation)
            
            DatePicker("Date", selection: $vm.eventDate, displayedComponents: [.date, .hourAndMinute])
            Picker("Age Group", selection: $vm.ageGroup) {
                Text("Infants").tag("Infants")
                Text("Children").tag("Children")
                Text("Teens").tag("Teens")
                Text("Adults").tag("Adults")
                Text("Seniors").tag("Seniors")
                Text("All Ages").tag("All Ages")
            }
            
            List{
                ForEach(options, id: \.self) {option in
                    MultipleSelectionRow(title: option , isSelected: selectedOptions.contains(option)){
                        if selectedOptions.contains(option) {
                            selectedOptions.remove(option)
                        }else{
                            selectedOptions.insert(option)
                        }
                    }
                }
            }
            
//            Picker("Language", selection: $vm.language) {
//                Text("English").tag("English")
//                Text("French").tag("French")
//                Text("Spanish").tag("Spanish")
//                Text("Arabic").tag("Arabic")
//                Text("Punjabi").tag("Punjabi")
//                Text("Other").tag("Other")
//                Text("All").tag("All")
//            }
            
            PhotosPicker(
                selection: $vm.eventImage,
                matching: .images,
                photoLibrary: .shared()){
                    VStack{
                        if let data = vm.eventImageData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 350, height: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .clipped()
                        } else {
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 300)
                                VStack{
                                    Text("+")
                                    Text("Select image for event")

                                }
                                                            }
                            }
                        }
                }.onChange(of: vm.eventImage) { _, _ in
                    Task{
                        let data = try? await vm.eventImage?.loadTransferable(type: Data.self)
                        await MainActor.run{
                            vm.eventImageData = data
                            displayedImageData = data
                        }
                    }
                }
                

            
            
            TextField("Event Description", text: $vm.eventDescription, axis: .vertical)
                .lineLimit(5...10)
            
            Button("Save"){
                Task {
                    await vm.saveEvent(ownerId: currentUserId)
                }
            }
        }.navigationTitle(Text("Add New Event"))
    }
}

#Preview {
    AddEventView()
}
