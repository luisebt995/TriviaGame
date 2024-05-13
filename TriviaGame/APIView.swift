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
    @State private var answer = ""
    
    var body: some View {
        NavigationView {
            List {
                //Text with question
                Text(dataGame.questionOut)
                //Text with category
                Text(dataGame.categoryOut)
                
                Spacer()
                
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
                
            }.navigationBarItems(
                leading:
                Button(action: {
                    authModel.signOut()
                },label: {
                    Image(systemName: "arrowshape.turn.up.left").font(.title)
                    .foregroundColor(.black)
                    
                })
            )
        }
    }
}

struct APIView_Previews: PreviewProvider {
    static var previews: some View {
        APIView(dataGame: APIViewModel())
    }
}
