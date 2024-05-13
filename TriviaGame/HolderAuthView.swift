//
//  ViewHolderAuth.swift
//  TriviaGame
//
//  Created by Luis on 8/5/24.
//
//  Bibliography:
//  Swift UI Firebase - Chapter 4

import SwiftUI

/*Redirect view depending of User status:
 nil: It goes to SignUpView
 User: It goes to MainMenuView*/

struct HolderAuthView: View {
    //Instance of AuthViewModel, used as EnvVar
    @EnvironmentObject private var authModel: AuthViewModel
    
    var body: some View {
        Group {
            if authModel.user == nil {
                SignUpView().environmentObject(authModel)
            }
            else {
                //DDBBView()
                APIView(dataGame: APIViewModel())
            }
        }
        .onAppear {authModel.listenToAuthState()}
    }
}

struct HolderAuthView_Previews: PreviewProvider {
    static var previews: some View {
        HolderAuthView()
    }
}
