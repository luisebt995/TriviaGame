//
//  CustomView.swift
//  TriviaGame
//
//  Created by Luis on 13/5/24.
//
//  Bibliography:
//  https://firebase.google.com/docs/auth/ios/manage-users

import SwiftUI

struct CustomView: View {
    //Instance of AuthViewModel, used as EnvVar
    @EnvironmentObject private var authModel: AuthViewModel
    
    //Chapter 12
    @Environment(\.presentationMode) var presentationMode
    
    //Interaction var
    @State private var displayName = ""
    @State private var photoURL = ""
    
    //Timer for update
    @State private var countDown = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            
            //Receive new username
            Text("Username")
                .padding(10)
            TextField("Enter Username",text: $displayName)
                .padding(10)
                .background(.white)
                .padding()
            
            Spacer()
            
            Text("Avatar")
            //Vstack with avatar Buttons
            VStack{
                HStack{
                    Button(""){
                        print("Button pressed")
                    }
                    .buttonStyle(AvatarButtonStyle(imageName: "penguinPic", selection: $photoURL))
                    Button(""){
                        print("Button pressed")
                    }
                    .buttonStyle(AvatarButtonStyle(imageName: "athleticclub", selection: $photoURL))
                    Button(""){
                        print("Button pressed")
                    }
                    .buttonStyle(AvatarButtonStyle(imageName: "lionPic", selection: $photoURL))
                }
                HStack{
                    Button(""){
                        print("Button pressed")
                    }
                    .buttonStyle(AvatarButtonStyle(imageName: "barcelonafc", selection: $photoURL))
                    Button(""){
                        print("Button pressed")
                    }
                    .buttonStyle(AvatarButtonStyle(imageName: "owlPic", selection: $photoURL))
                    Button(""){
                        print("Button pressed")
                    }
                    .buttonStyle(AvatarButtonStyle(imageName: "realmadrid", selection: $photoURL))
                }
            }
            
            Spacer()
            
            //Save new user preferences
            Button(action: {
                authModel.setDisplayName(displayName: displayName)
                authModel.setPhotoURL(photoURL: photoURL)
            }) {
                Text("Save Changes")
            }
            //Timer for update
            .onReceive(timer) {_ in
                if countDown == 3 {
                    authModel.update()
                    
                }
                else {
                    countDown += 1
                }
            }
        }
        //@State variable for user interaction
        .onAppear {
            photoURL = authModel.getPhotoURL()
            displayName = authModel.getDisplayName()
        }
        //Button to dismiss modal Chapter 12 - SwiftUI
        .overlay(
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.down.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    })
                    .padding(.trailing, 20)
                    .padding(.top, 40)
                    Spacer()
                }
            }
        )
        //Background of application
        .background(
            LinearGradient(gradient: Gradient(colors: [.cyan, .white]), startPoint: .top, endPoint: .bottom)
        )
    }
}

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        CustomView().environmentObject(AuthViewModel())
    }
}
