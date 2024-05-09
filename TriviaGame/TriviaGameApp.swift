//
//  TriviaGameApp.swift
//  TriviaGame
//
//  Created by Luis on 6/5/24.
//
//  Bibliography:
//  Swift UI Firebase - Chapter 4

import SwiftUI
import FirebaseCore

//Connect to Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?  = nil) -> Bool {
    return true
  }
}
@main
struct TriviaGameApp: App {
    
    //Initiate configuration
    var db:Void = FirebaseApp.configure()
    
    var body: some Scene {
        WindowGroup {
            HolderAuthView().environmentObject(AuthViewModel())
        }
    }
}
