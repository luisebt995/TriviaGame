//
//  ViewAPI.swift
//  TriviaGame
//
//  Created by Luis on 6/5/24.
//
//  Bibliography:
//  Mastering SwiftUI - Chapter 15
//  https://github.com/luisebt995/APIExample

import SwiftUI

struct APIView: View {
    //Instance of AuthViewModel, used as EnvVar
    @EnvironmentObject private var authModel: AuthViewModel
    
    //Instance of APIViewModel
    @ObservedObject var dataGame : APIViewModel
    
    //Control modal View
    @State private var showingSheet = false
    
    //Show result of question
    @State private var answer = ""
    
    //Control modal View
    @State private var showingCustom = false
    
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
                List {
                    
                    //Text with question
                    Text(dataGame.questionOut)
                        .frame(width: 200, height: 180)
                    //Text with category
                    Text(dataGame.categoryOut)
                        .frame(width: 200, height: 40)
                }
                .frame(width: 320, height: 330)
                    
                    Spacer()
                
                List {
                    //Texts with answers, using random distribution.
                    switch dataGame.typeOut {
                    case "multiple":
                        if dataGame.incorrect_answersOut[0] != "" {
                            ForEach(0..<4) { i in
                                if  i == 3 {
                                    if dataGame.randomOrder == 3 {
                                    Text(dataGame.correct_answerOut)
                                        .onTapGesture {
                                            answer = "correct"
                                        }
                                    }
                                } else {
                                    if dataGame.randomOrder == i {
                                        Text(dataGame.correct_answerOut)
                                            .onTapGesture {
                                                answer = "correct"
                                            }
                                    }
                                    Text(dataGame.incorrect_answersOut[i])
                                        .onTapGesture {
                                            answer = "incorrect"
                                        }
                                }
                            }
                        }
                    case "boolean":
                        if  dataGame.randomOrder == 0 {
                            Text(dataGame.correct_answerOut)
                                .onTapGesture {
                                    answer = "correct"
                                }
                            Text(dataGame.incorrect_answersOut[0])
                                .onTapGesture {
                                    answer = "incorrect"
                                }
                        } else {
                            Text(dataGame.incorrect_answersOut[0])
                                .onTapGesture {
                                    answer = "incorrect"
                                }
                            Text(dataGame.correct_answerOut)
                                .onTapGesture {
                                    answer = "correct"
                                }
                        }
                    default:
                        Text("")
                    }
                    
                    //Debug
                    Text(answer)
                    
                    //Calls information from API
                    Button(action: {
                        dataGame.urlCall()
                        answer = ""
                    }) {
                        Text("Generate")
                    }
                    
                    //Cycle through the questions
                    Button(action: {
                        dataGame.nextQuestion()
                        answer = ""
                    }) {
                        Text("Next")
                    }
                    
                }
                //Sign Out of User session.
                .navigationBarItems(
                    leading:
                    Button(action: {
                        authModel.signOut()
                    },label: {
                        Image(systemName: "arrowshape.turn.up.left").font(.title)
                        .foregroundColor(.black)
                        
                    }),
                    //Modal to CustomView.
                    trailing:
                    Button(action: {
                        showingCustom.toggle()
                    },label: {
                        Image(systemName: "gear").font(.title)
                        .foregroundColor(.black)
                        
                    })
                    .sheet(isPresented: $showingCustom) {
                        CustomView()
                }
                )
            }
        }.onAppear{authModel.update()}
    }
}

struct APIView_Previews: PreviewProvider {
    static var previews: some View {
        APIView(dataGame: APIViewModel()).environmentObject(AuthViewModel())
    }
}
