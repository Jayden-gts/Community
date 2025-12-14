//
//  SignupView.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-12-13. 991691793
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
        NavigationStack {
            VStack {
                Spacer()
                
                VStack(spacing: 25) {
                    VStack(spacing: 8) {
                        Text("Create Account")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(red: 50/255, green: 100/255, blue: 30/255))
                        Text("Sign up to get started")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 15) {
                        TextField("Email", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                            .padding(.horizontal)
                        
                        TextField("Password", text: $password)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        
                        TextField("Confirm Password", text: $confirmPassword)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                    }
                    
                    Button(action: {
                        // Example validation
                        if email.isEmpty || password.isEmpty {
                            errorMessage = "Email and password cannot be empty"
                            showError = true
                            return
                        }
                        if password != confirmPassword {
                            errorMessage = "Passwords do not match"
                            showError = true
                            return
                        }
                        if !email.contains("@") || !email.contains(".") {
                            errorMessage = "Enter a valid email"
                            showError = true
                            return
                        }
                        // Proceed with signup
                        session.signUp(email: email, password: password)
                        session.login(email: email)
                    }) {
                        Text("Create Account")
                            .foregroundColor(.white)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 50/255, green: 100/255, blue: 30/255))
                            .cornerRadius(12)
                            .shadow(radius: 2)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .frame(maxHeight: .infinity)
                
                Spacer()
            }
            .alert(errorMessage, isPresented: $showError) {}  // attach to the VStack, not Button
        }
    }
}
