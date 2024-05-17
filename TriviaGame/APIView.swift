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
    
    //Keep index of selected wrong answer
    @State private var answerControl = -1
    
    //Maintain flow with answers and next button
    @State private var flowControl = false
    
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
                List {
                    
                    //Text with question
                    HStack {
                        Spacer()
                        Text(dataGame.questionOut)
                            .frame(width: 200, height: 180)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                    //Text with category
                    HStack {
                        Spacer()
                        Text(dataGame.categoryOut)
                            .frame(width: 200, height: 40)
                            .font(.subheadline)
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                }
                .frame(width: 320, height: 330, alignment: .center)
                .listStyle(.plain)
                .cornerRadius(10)
                    
                List {
                    //Texts with answers, using random distribution.
                    switch dataGame.typeOut {
                    case "multiple":
                        if dataGame.incorrect_answersOut[0] != "" && dataGame.incorrect_answersOut.count > 2  {
                            ForEach(0..<4) { i in
                                if  i == 3 {
                                    if dataGame.randomOrder == 3 {
                                        Button(dataGame.correct_answerOut){
                                            if !flowControl {
                                                flowControl = true
                                            }
                                        }
                                        .frame(alignment: .center)
                                        .buttonStyle(AnswerButtonStyle(typeAnswer: true, answerNum: -1 , answerControl: $answerControl, flowControl: $flowControl))
                                        .listRowSeparator(.hidden)
                                    }
                                } else {
                                    if dataGame.randomOrder == i {
                                        Button(dataGame.correct_answerOut){
                                            if !flowControl {
                                                flowControl = true
                                            }
                                        }
                                        .frame(alignment: .center)
                                        .buttonStyle(AnswerButtonStyle(typeAnswer: true, answerNum: -1 , answerControl: $answerControl, flowControl: $flowControl))
                                        .listRowSeparator(.hidden)
                                    }
                                    Button(dataGame.incorrect_answersOut[i]){
                                        if !flowControl {
                                            flowControl = true
                                            answerControl = i
                                        }
                                    }
                                    .buttonStyle(AnswerButtonStyle(typeAnswer: false, answerNum: i , answerControl: $answerControl, flowControl: $flowControl))
                                    .listRowSeparator(.hidden)
                                }
                            }
                        }
                    case "boolean":
                        if  dataGame.randomOrder == 0 {
                            Button(dataGame.correct_answerOut){
                                if !flowControl {
                                    flowControl = true
                                }
                            }
                            .frame(alignment: .center)
                            .buttonStyle(AnswerButtonStyle(typeAnswer: true, answerNum: -1 , answerControl: $answerControl, flowControl: $flowControl))
                            .listRowSeparator(.hidden)
                            Button(dataGame.incorrect_answersOut[0]){
                                if !flowControl {
                                    flowControl = true
                                    answerControl = 0
                                }
                            }
                            .buttonStyle(AnswerButtonStyle(typeAnswer: false, answerNum: 0 , answerControl: $answerControl, flowControl: $flowControl))
                            .listRowSeparator(.hidden)
                        } else {
                            Button(dataGame.incorrect_answersOut[0]){
                                if !flowControl {
                                    flowControl = true
                                    answerControl = 0
                                }
                            }
                            .buttonStyle(AnswerButtonStyle(typeAnswer: false, answerNum: 0 , answerControl: $answerControl, flowControl: $flowControl))
                            .listRowSeparator(.hidden)
                            Button(dataGame.correct_answerOut){
                                if !flowControl {
                                    flowControl = true
                                }
                            }
                            .frame(alignment: .center)
                            .buttonStyle(AnswerButtonStyle(typeAnswer: true, answerNum: -1 , answerControl: $answerControl, flowControl: $flowControl))
                            .listRowSeparator(.hidden)
                        }
                    default:
                        Text("")
                            .listRowSeparator(.hidden)
                    }
                    
                }
                .frame(width: 320, height: 180)
                .listStyle(.plain)
                .cornerRadius(10)
                
                HStack{
                    Spacer()
                    
                    //Cycle through the questions
                    Button(""){
                        dataGame.nextQuestion()
                        flowControl = false
                        answerControl = -1
                    }
                    .buttonStyle(NextButtonStyle(flowControl: $flowControl))
                    .disabled(!flowControl)
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
                LinearGradient(gradient: Gradient(colors: [.cyan, .white]), startPoint: .top, endPoint: .bottom)
            )
        }
        .onAppear{authModel.update()}
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct APIView_Previews: PreviewProvider {
    static var previews: some View {
        APIView(dataGame: APIViewModel()).environmentObject(AuthViewModel())
    }
}
