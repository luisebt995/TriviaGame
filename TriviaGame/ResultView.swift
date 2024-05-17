//
//  ResultView.swift
//  TriviaGame
//
//  Created by Luis on 13/5/24.
//

import SwiftUI

struct ResultView: View {
    //Instance of AuthViewModel, used as EnvVar
    @EnvironmentObject private var authModel: AuthViewModel
    
    //Instance of DDBBViewModel
    @StateObject var ddbbModel = DDBBViewModel()
    
    //NavigationLink to other views
    @State private var goToMainMenuView = false
    
    var corrects : Int
    var amount : Int
    
    var body: some View {
        NavigationView {
            VStack {
                //User Information
                HStack {
                    Image(authModel.photoURLView)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                    Text(authModel.displayNameView)
                }
                .frame(width: 150, height: 30)
                .padding(5)
                .background(.white)
                .cornerRadius(10)
                
                Spacer()
                
                Group {
                    Text("Results")
                    HStack {
                        Text("\(corrects)")
                        Text("/")
                        Text("\(amount)")
                    }
                    Text("Corrects!")
                }
                .font(.largeTitle)
                
                Spacer()
                
                HStack {
                    Spacer()
                    //Cycle through the questions
                    ZStack {
                        NavigationLink(destination: MainMenuView(), isActive: $goToMainMenuView)
                        {
                            EmptyView()
                        }
                        Button("Continue"){
                            goToMainMenuView = true
                        }
                        .buttonStyle(ContinueButtonStyle())
                    }
                }
            }
            //Make VStack fill whole screen and apply gradient color
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .top
            )
            .background(
                LinearGradient(gradient: Gradient(colors: [.yellow, .white]), startPoint: .top, endPoint: .bottom)
            )
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(corrects: 8, amount: 10)
    }
}
