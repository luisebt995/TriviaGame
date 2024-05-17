//
//  MainMenuView.swift
//  TriviaGame
//
//  Created by Luis on 13/5/24.
//

import SwiftUI

struct MainMenuView: View {
    //Instance of AuthViewModel, used as EnvVar
    @EnvironmentObject private var authModel: AuthViewModel
    
    //Instance to obtain question before passing to APIView
    @StateObject private var apiModel = APIViewModel()
    
    //Control modal View
    @State private var showingCustom = false
    
    //Amount of questions
    @State private var amountQuestions = 10
    
    //NavigationLink to other views
    @State private var goToAPIView = false
    @State private var goToLeaderboardView = false
    
    var body: some View {
        NavigationView {
            VStack{
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
                
                //Buttons to increase or decrease number of questions
                HStack {
                    Spacer()
                    Button {
                        if (amountQuestions > 2) {
                            amountQuestions -= 1
                        }
                    } label : {
                        Image(systemName: "arrowtriangle.left.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                    }
                    Text("\(amountQuestions)")
                        .font(.system(size: 17))
                        .frame(width: 50, height: 50, alignment: .center)
                        .background(.white)
                        .cornerRadius(15)
                    Button {
                        if (amountQuestions < 30) {
                            amountQuestions += 1
                        }
                    } label : {
                        Image(systemName: "arrowtriangle.right.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                
                //Button to go to APIView
                ZStack {
                    NavigationLink(destination: APIView(dataGame: apiModel), isActive: $goToAPIView)
                    {
                        EmptyView()
                    }
                    Button(){
                        apiModel.amount = amountQuestions
                        apiModel.urlCall()
                        goToAPIView.toggle()
                    } label: {
                        HStack{
                            Text("Play")
                        }
                    }
                    //.buttonStyle(AnimationLB(changeView: $goToDibujarVista))
                }
                
                //Button to go to LeaderboardView
                ZStack {
                    NavigationLink(destination: LeaderboardView(), isActive: $goToLeaderboardView)
                    {
                        EmptyView()
                    }
                    Button(){
                        goToLeaderboardView.toggle()
                    } label: {
                        HStack{
                            Text("Leaderboard")
                        }
                    }
                    //.buttonStyle(AnimationLB(changeView: $goToDibujarVista))
                }
                
                Spacer()
                
                //Sign Out of User session.
                .navigationBarItems(
                    leading:
                    Button(action: {
                        authModel.signOut()
                    },label: {
                        Image(systemName: "arrowshape.turn.up.left").font(.title)
                        .foregroundColor(.white)
                        
                    }),
                    //Modal to CustomView.
                    trailing:
                    Button(action: {
                        showingCustom.toggle()
                    },label: {
                        Image(systemName: "gear").font(.title)
                        .foregroundColor(.white)
                        
                    })
                    .sheet(isPresented: $showingCustom) {
                        CustomView()
                }
                )
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
                LinearGradient(gradient: Gradient(colors: [.cyan, .white]), startPoint: .top, endPoint: .bottom)
            )
        }
        .onAppear{authModel.update()}
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
