//
//  SignupView.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-12-13.
//

import SwiftUI


// MARK: - Signup View
struct SignupView: View {
    @EnvironmentObject var session: SessionManager

    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showError = false
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Spacer()

                // Header
                VStack(spacing: 8) {
                    Text("Create Account")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(red: 50/255, green: 100/255, blue: 30/255))
                    Text("Sign up to get started")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                // Form Fields
                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .padding(.horizontal)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                }

                // Create Account Button
                Button(action: {
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

                Spacer()
            }
            .padding()
            .alert(errorMessage, isPresented: $showError) {}
        }
    }
}


