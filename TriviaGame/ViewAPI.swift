//
//  ViewAPI.swift
//  TriviaGame
//
//  Created by Luis on 6/5/24.
//

import SwiftUI

struct ViewAPI: View {
    //Instance of ViewModelAPI
    @ObservedObject var dataGame : ViewModelAPI
    
    var body: some View {
        VStack{
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
        }
    }
}

struct ViewAPI_Previews: PreviewProvider {
    static var previews: some View {
        ViewAPI(dataGame: ViewModelAPI())
    }
}
