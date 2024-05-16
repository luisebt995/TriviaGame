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
    
    //Holder var that updates when it receives information from the API
    var questionsReady : DataAPI?
    
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
    @Published var randomOrder : Int = 0
    
    private var cancellableSet : Set<AnyCancellable> = []
    
    
    /*Assignation of variable with Combine and MVVM
     Mastering SwiftUI - Chapter 15*/
    
    init(){
        //Update holder var when questions receive data from API
        $questions
            .receive(on: RunLoop.main)
            .map { questions in
                if let questions = questions {
                    //Use .decoded to decode from HTML format
                    return questions
                }
                else{ return nil}
            }
            .assign(to: \.questionsReady, on: self)
            .store(in: &cancellableSet)
        
        //Assign value from API to typeOut
        $index
            .receive(on: RunLoop.main)
            .map { index in
                if let type = self.questionsReady?.results[index].type {
                    //Use .decoded to decode from HTML format
                    return type.decoded
                }
                else{ return ""}
            }
            .assign(to: \.typeOut, on: self)
            .store(in: &cancellableSet)
        
        //Assign value from API to incorrect_answersOut
        $index
            .receive(on: RunLoop.main)
            .map { index in
                if var incorrect_answer = self.questionsReady?.results[index].incorrect_answers {
                    for i in 0..<incorrect_answer.count {
                        incorrect_answer[i] = incorrect_answer[i].decoded
                    }
                    return incorrect_answer
                }
                else{ return [""]}
            }
            .assign(to: \.incorrect_answersOut, on: self)
            .store(in: &cancellableSet)
        
        //Assign value from API to questionOut
        $index
            .receive(on: RunLoop.main)
            .map { index in
                if let question = self.questionsReady?.results[index].question {
                    //Use .decoded to decode from HTML format
                    return question.decoded
                }
                else{ return ""}
            }
            .assign(to: \.questionOut, on: self)
            .store(in: &cancellableSet)
        
        //Assign value from API to categoryOut
        $index
            .receive(on: RunLoop.main)
            .map { index in
                if let category = self.questionsReady?.results[index].category {
                    return category.decoded
                }
                else{ return ""}
            }
            .assign(to: \.categoryOut, on: self)
            .store(in: &cancellableSet)

        //Assign value from API to correct_answerOut
        $index
            .receive(on: RunLoop.main)
            .map { index in
                if let correct_answer = self.questionsReady?.results[index].correct_answer {
                    return correct_answer.decoded
                }
                else{ return ""}
            }
            .assign(to: \.correct_answerOut, on: self)
            .store(in: &cancellableSet)
        
        //Generate random number for randomize questions.
        $index
            .receive(on: RunLoop.main)
            .map { index in
                if let type = self.questionsReady?.results[index].type {
                    switch type {
                    case "multiple":
                        let randomInt = Int.random(in: 0..<4)
                        return randomInt
                    case "boolean":
                        let randomInt = Int.random(in: 0..<2)
                        return randomInt
                    default:
                        let randomInt = 0
                        return randomInt
                    }
                }
                else { return 0 }
            }
            .assign(to: \.randomOrder, on: self)
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
                        self.resetIndex()
                    }
                }
            
        }.resume()
    }
    
    //Inspect changes for variable assignation, Output with Combine and MVVM
    func nextQuestion() {
        if (self.index + 1 == self.amount){
            self.index = 0
        }
        else {
            self.index += 1
        }
    }
    
    //Trigger new view in ViewAPI
    private func resetIndex() {
        self.index = 0
    }
}
