//
//  LoginView.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-12-13. 991691793
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: SessionManager

    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                VStack(spacing: 25) {
                    VStack(alignment: .center, spacing: 4) {
                        Text("Welcome Back!")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(red: 50/255, green: 100/255, blue: 30/255))
                        Text("Login to get started")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 30)

                    // Email field
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)

                    // Password field
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)

                    // Login button
                    Button(action: {
                        if session.validateLogin(email: email, password: password) {
                            session.login(email: email)
                        } else {
                            errorMessage = "Invalid email or password"
                            showError = true
                        }
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 50/255, green: 100/255, blue: 30/255))
                            .cornerRadius(12)
                    }

                    // Signup link
                    NavigationLink(destination: SignupView().environmentObject(session)) {
                        Text("Don't have an account? Sign Up")
                            .font(.subheadline)
                            .foregroundColor(Color(red: 50/255, green: 100/255, blue: 30/255))
                            .padding(.top, 10)
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .alert(errorMessage, isPresented: $showError) {}
        }
    }
}

#Preview {
    LoginView().environmentObject(SessionManager())
}
