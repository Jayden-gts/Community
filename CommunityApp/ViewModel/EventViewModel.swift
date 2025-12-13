//
//  EventViewModel.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-15.991746683
//

import Foundation

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    
    func fetchEvents(city: String)  {
        
        let apiKey = "LRQC0K5dMrAim5j1fCEpTcbsthsAUaWZ"
      
        let url = "https://app.ticketmaster.com/discovery/v2/events.json?city=\(city)&apikey=\(apiKey)"
        

        guard let urlRequest = URL(string: url) else {return}
        var request = URLRequest(url:urlRequest)
        request.httpMethod = "GET"
      
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Request error:", error)
                return
            }
            
            guard let data = data else { return }
            
            if let str = String(data: data, encoding: .utf8) {
                
            }
            
            do {
                let decoded = try JSONDecoder().decode(TicketMasterResponse.self, from: data)
                DispatchQueue.main.async {
                    self.events = decoded._embedded?.events ?? []
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
}
