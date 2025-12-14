//
//  LoginView.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-12-13.
//


// add the errors and make it look prettier with UI and stuff 


//import SwiftUI
//
//struct LoginView: View  {
//    @EnvironmentObject var session: SessionManager
//
//
//    @State private var email = ""
//    @State private var password = ""
//    @State private var showError = false
//    
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Login").font(.largeTitle).bold()
//            
//            TextField("Email", text: $email)
//                .textFieldStyle(.roundedBorder)
//                .autocapitalization(.none)
//            
//            SecureField("Password", text: $password)
//                .textFieldStyle(.roundedBorder)
//            
//            Button("Login") {
//                if session.validateLogin(email: email, password: password) {
//                    session.login(email: email)
//                } else {
//                    showError = true
//                }
//            }
//            .padding()
//           
//            
//            NavigationLink("Sign Up", destination: SignupView().environmentObject(session))
//                            .padding(.top, 10)
//                    }
//                    .padding()
//                    .alert("Invalid credentials", isPresented: $showError) {}
//        
//        }
//    }
//import SwiftUI
//
//struct LoginView: View {
//    @EnvironmentObject var session: SessionManager
//
//    @State private var email = ""
//    @State private var password = ""
//    @State private var showError = false
//    @State private var errorMessage = ""
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 25) {
//                // Welcome text
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("Welcome Back!")
//                        .font(.largeTitle)
//                        .bold()
//                        .foregroundColor(Color(red: 50/255, green: 100/255, blue: 30/255))
//                    Text("Login to get started")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.bottom, 30)
//
//                // Email field
//                TextField("Email", text: $email)
//                    .textFieldStyle(.roundedBorder)
//                    .autocapitalization(.none)
//
//                // Password field
//                SecureField("Password", text: $password)
//                    .textFieldStyle(.roundedBorder)
//
//                // Login button
//                Button(action: {
//                    if session.validateLogin(email: email, password: password) {
//                        session.login(email: email)
//                    } else {
//                        errorMessage = "Invalid email or password"
//                        showError = true
//                    }
//                }) {
//                    Text("Login")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color(red: 50/255, green: 100/255, blue: 30/255))
//                        .cornerRadius(12)
//                }
//
//                // Signup link
//                NavigationLink(destination: SignupView().environmentObject(session)) {
//                    Text("Don't have an account? Sign Up")
//                        .font(.subheadline)
//                        .foregroundColor(Color(red: 50/255, green: 100/255, blue: 30/255))
//                        .padding(.top, 10)
//                }
//
//                Spacer()
//            }
//            .padding()
//            .alert(errorMessage, isPresented: $showError) {}
//        }
//    }
//}
//
//#Preview {
//    LoginView().environmentObject(SessionManager())
//}
//
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
                Spacer() // Push content to center vertically
                
                VStack(spacing: 25) {
                    // Welcome text
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
                
                Spacer() // Push content to center vertically
            }
            .padding()
            .alert(errorMessage, isPresented: $showError) {}
        }
    }
}

#Preview {
    LoginView().environmentObject(SessionManager())
}
