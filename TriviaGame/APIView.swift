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
    
    var body: some View {
        NavigationView {
            List {
                Spacer()
                
                //Text with question
                Text(dataGame.questionOut)
                //Text with category
                Text(dataGame.categoryOut)
                
                Spacer()
                
                //Text with answers
                Text(dataGame.correct_answerOut)
                ForEach(dataGame.incorrect_answersOut, id:\.self){ incorrect in
                    Text(incorrect)
                }
                
                Spacer()
                
                HStack{
                    Spacer()
                    
                    //Calls information from API
                    Button(action: {
                        dataGame.urlCall()
                    }) {
                        Text("Generate")
                    }
                    
                    Spacer()
                    
                    //Cycle through the questions
                    Button(action: {
                        dataGame.nextQuestion()
                    }) {
                        Text("Next")
                    }
                    
                    Spacer()
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
