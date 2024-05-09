//
//  ViewResetPassword.swift
//  TriviaGame
//
//  Created by Luis on 9/5/24.
//
//  Bibliography:
//  Swift UI Firebase - Chapter 4
//  Mastering SwiftUI - Chapter 12

import SwiftUI

struct ResetPasswordView: View {
    //Instance of AuthViewModel, used as EnvVar
    @EnvironmentObject var authModel: AuthViewModel
    
    //Use to exit modal 
    @Environment(\.presentationMode) var presentationMode
    
    //Recieve input from user and send it to AuthViewModel() functions
    @State private var emailAddress: String = ""
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Email", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                }
                
                Section(footer: Text("Once sent, check your email to reset your password.")) {
                    Button(action: {
                        authModel.resetPassword(emailAddress:emailAddress)
                        
                    })
                    {
                        Text("Send email link").bold()
                    }
                }
            }
            .navigationTitle("Reset password")
            .toolbar {
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
