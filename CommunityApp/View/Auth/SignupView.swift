//
//  SignupView.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-12-13.
//

import SwiftUI

struct SignupView: View {
    
    @EnvironmentObject var session: SessionManager
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showError = false
    @State private var errorMessage: String = ""

    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up").font(.largeTitle).bold()
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
            
            Button("Create Account") {
                guard !email.isEmpty && !password.isEmpty else {
                    errorMessage = "Email and password cannot be empty"
                    showError = true
                    return
                }
                
                guard password == confirmPassword else {
                    errorMessage = "Passwords do not match"
                    showError = true
                    return
                }
                
                session.signUp(email: email, password: password)
                session.login(email: email)
            }
            .padding()
            
        }
        .padding()
        .alert(errorMessage, isPresented: $showError) {}
    }
                
}
