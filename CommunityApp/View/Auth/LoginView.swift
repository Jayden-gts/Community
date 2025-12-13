//
//  LoginView.swift
//  CommunityApp
//
//  Created by Laiba Ahmed on 2025-12-13.
//

import SwiftUI

struct LoginView: View  {
    @EnvironmentObject var session: SessionManager


    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login").font(.largeTitle).bold()
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            Button("Login") {
                if session.validateLogin(email: email, password: password) {
                    session.login(email: email)
                } else {
                    showError = true
                }
            }
            .padding()
           
            
            NavigationLink("Sign Up", destination: SignupView().environmentObject(session))
                            .padding(.top, 10)
                    }
                    .padding()
                    .alert("Invalid credentials", isPresented: $showError) {}
        
        }
    }
