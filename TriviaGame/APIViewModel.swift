//
//  ViewModelAPI.swift
//  TriviaGame
//
//  Created by Luis on 6/5/24.
//
//  Bibliography:
//  Mastering SwiftUI - Chapter 15
//  https://github.com/luisebt995/APIExample

import SwiftUI
import Foundation
import Combine

//ViewModel Basic Structure
class APIViewModel : ObservableObject {
    //Input
    @Published var questions : DataAPI?
    @Published var index : Int = -1
    @Published var amount : Int = 10
    
    //Output
    @Published var typeOut : String = ""
    @Published var categoryOut : String = ""
    @Published var questionOut : String = ""
    @Published var correct_answerOut : String = ""
    @Published var incorrect_answersOut : [String] = []
    
    private var cancellableSet : Set<AnyCancellable> = []
    
    
    /*Assignation of variable with Combine and MVVM
     Mastering SwiftUI - Chapter 15*/
    
    init(){
        //Assign value from API to typeOut
        $index
            .receive(on: RunLoop.main)
            .map { index in
                if let type = self.questions?.results[index].type {
                    return type
                }
                else{ return ""}
            }
            .assign(to: \.typeOut, on: self)
            .store(in: &cancellableSet)
        
        //Assign value from API to categoryOut
        $index
            .receive(on: RunLoop.main)
            .map { index in
                if let category = self.questions?.results[index].category {
                    return category.decoded
                }
                else{ return ""}
            }
            .assign(to: \.categoryOut, on: self)
            .store(in: &cancellableSet)
        
        //Assign value from API to questionOut
        $index
            .receive(on: RunLoop.main)
            .map { index in
                if let question = self.questions?.results[index].question {
                    //Use .decoded to decode from HTML format
                    return question.decoded
                }
                else{ return ""}
            }
            .assign(to: \.questionOut, on: self)
            .store(in: &cancellableSet)
        
        //Assign value from API to correct_answerOut
        $index
            .receive(on: RunLoop.main)
            .map { index in
                if let correct_answer = self.questions?.results[index].correct_answer {
                    return correct_answer
                }
                else{ return ""}
            }
            .assign(to: \.correct_answerOut, on: self)
            .store(in: &cancellableSet)
        
        //Assign value from API to correct_answerOut
        $index
            .receive(on: RunLoop.main)
            .map { index in
                if let incorrect_answer = self.questions?.results[index].incorrect_answers {
                    return incorrect_answer
                }
                else{ return [""]}
            }
            .assign(to: \.incorrect_answersOut, on: self)
            .store(in: &cancellableSet)
    }
    
    /*Get trivia information from opentdb.com
     amount of question depend of the input from "amount" variable */
    func urlCall() {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=\(amount)") else{return}
        
        //Establish URL session
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            //Parse data from JSON to our own format "DataAPI.self"
            if let datosDecodificados = try? JSONDecoder().decode(DataAPI.self,from:data){
                //Assignn the info from our datosDecodificados variable to self.questions
                    DispatchQueue.main.async {
                        self.questions = datosDecodificados
                    }
                }
            
        }.resume()
        //Trigger new view in ViewAPI
        self.index = 0
    }
    
    //Inspect changes for variable assignation, Output with Combine and MVVM
    func nextQuestion() {
        self.index += 1
    }
}
