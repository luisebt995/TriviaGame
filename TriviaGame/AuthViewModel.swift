//
//  ViewModelAuth.swift
//  TriviaGame
//
//  Created by Luis on 8/5/24.
//
//  Bibliography:
//  Swift UI Firebase - Chapter 4
//  https://firebase.google.com/docs/auth/ios/google-signin?hl=es

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore
import GoogleSignIn


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
    
    //Function to signIn with Google SDK
    func signInWithGoogle(){
        guard let clientID = FirebaseApp.app()?.options.clientID else {return}
        //Capturamos la configuración con unestro IDCliente

        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.configuration = config

        //Cambiar a región España en el emulador para evitar errores en desfases de tiempo
        /*como no estamos en una vista, sino en un ViewModel, hemos creado Application_utility, donde creamos una pantalla o vista del tipo UIViewController, sino pondríamos self en el parámetro withPresenting.
         To see more detail see AuthModel() Bibliography*/

        GIDSignIn.sharedInstance.signIn(withPresenting: ApplicationUtility.rootViewController) {user,error in
            if let error = error {
                print("\(error.localizedDescription)")
                return
            }

            guard let user = user?.user,
                  let idToken =  user.idToken else {
                        return
            }
            let accesToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accesToken.tokenString)
        
            //Por último, nos autenticamos con las credenciales proporcionadas
            Auth.auth().signIn(with: credential) {res, error in
                if let error = error {
                    print("\(error.localizedDescription)")
                    return
                }
                guard let user = res?.user else {return}
                print("USUARIO dentro de SignIn: \(user)")
            }
        }
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
