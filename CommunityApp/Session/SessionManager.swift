//
//  SessionManager.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-12-13.
//

import SwiftUI

@MainActor
final class SessionManager: ObservableObject {
    
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }
    
    @Published var currentUserEmail: String {
        didSet {
            UserDefaults.standard.set(currentUserEmail, forKey: "currentUserEmail")
        }
    }
    
    init() {
        
        // TESTING 
        // Force a fresh test
            self.isLoggedIn = false
            self.currentUserEmail = ""
        
        
        //self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        //self.userName = UserDefaults.standard.string(forKey: "userName") ?? ""
    }
    
    func login(email: String){
        currentUserEmail = email
        isLoggedIn = true
    }
    
    func logout(){
        isLoggedIn = false
        currentUserEmail = ""
    }
    
    func signUp(email: String, password: String){
        var users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [:]
        users[email] = password
        UserDefaults.standard.set(users, forKey: "users")
    }
    
    func validateLogin(email: String, password: String) -> Bool {
        var users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [:]
        return users[email] == password
    }
}
