//
//  ViewModelAuth.swift
//  TriviaGame
//
//  Created by Luis on 8/5/24.
//
//  Bibliography:
//  Swift UI Firebase - Chapter 4

import SwiftUI
import FirebaseAuth
import FirebaseFirestore


/*Manage all authentification attr and func*/
final class AuthViewModel: ObservableObject {
    @Published var user: User?
    
    //Keep track of previous User information for persistance.
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                return
            }
            self.user = user
        }
    }
    
    //Function to sign-in
    func signIn(emailAddress: String, password: String) {
        Auth.auth().signIn(withEmail: emailAddress, password: password) { result, error in
            if let error = error {
                print("an error occurred: \(error.localizedDescription)")
                return
            }
        }
    }
    
    //New signUp function that creates a new collection for each user
    func signUp(emailAddress: String, password: String) {
        Auth.auth().createUser(withEmail: emailAddress, password: password) { result, error in
            if let error = error {
                print("DEBUG: error \(error.localizedDescription)")
            } else {
                print("DEBUG: Succesfully created user with ID\(self.user?.uid ?? "")")
                guard let uid = Auth.auth().currentUser?.uid
                else { return }
                do {
                    _ = try Firestore.firestore().collection("UserData").document(uid).collection("WLR").addDocument(from: UserData(corrects: 0, incorrects: 0, ratio: 0))
                }
                catch {
                    print(error.localizedDescription)
                    return
                }
                print("Success")
            }
        }
    }
    
    //Function to logout
    func signOut() {
        do {
            try Auth.auth().signOut()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    //Function to reset password
    func resetPassword(emailAddress: String) {
        Auth.auth().sendPasswordReset(withEmail: emailAddress)
    }
    
    
    /*
     Old functions
     
    //Function to create an account
    func oldsignUp(emailAddress: String, password: String) {
        Auth.auth().createUser(withEmail: emailAddress, password: password) { result, error in
            if let error = error {
                print("an error occurred: \(error.localizedDescription)")
                return
            }
        }
    }*/
}
