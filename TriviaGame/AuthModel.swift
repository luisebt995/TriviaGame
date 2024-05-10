//
//  AuthModel.swift
//  TriviaGame
//
//  Created by Luis on 10/5/24.
//
//  Bibliography:
//  https://stackoverflow.com/questions/74908372/how-to-pass-rootviewcontroller-to-google-sign-in-in-swiftui

import Foundation
import UIKit

final class ApplicationUtility{
    
    static var rootViewController:UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        return root
    }
}
