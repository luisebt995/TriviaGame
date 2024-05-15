//
//  ViewSignUp.swift
//  TriviaGame
//
//  Created by Luis on 8/5/24.
//
//  Bibliography:
//  Swift UI Firebase - Chapter 4
//  Mastering SwiftUI - Chapter 12
//  https://firebase.google.com/docs/auth/ios/google-signin?hl=es

import SwiftUI

/*New user registration UI*/
struct SignUpView: View {
    //Instance of AuthViewModel, used as EnvVar
    @EnvironmentObject private var authModel: AuthViewModel
    
    //Recieve input from user and send it to AuthViewModel() functions
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    
    //Control modal View
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Email", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $password)
                    
                }
                Section {
                    Button(action: {
                        authModel.signUp(emailAddress: emailAddress, password: password)
                    }) {
                        Text("Sign Up").bold()
                    }
                    
                }
                Section(header: Text("If you already have an account:")) {
                    Button(action: {
                        authModel.signIn(emailAddress: emailAddress, password: password)
                    }) {
                        Text("Sign In")
                    }
                }
                Section(header: Text("If you already have an account with Google:")) {
                    Button(action: {
                        authModel.signInWithGoogle()
                    }) {
                        Text("Sign In with Google")
                    }
                }
            }.navigationTitle("Welcome")
                .toolbar {
                    ToolbarItemGroup(placement: .cancellationAction) {
                        Button {
                            showingSheet.toggle()
                            
                        }label: {
                            Text("Forgot password?")
                            
                        }
                        .sheet(isPresented: $showingSheet) {
                            ResetPasswordView()
                        }
                    }
                }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
