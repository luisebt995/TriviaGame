//
//  ModalAPI.swift
//  TriviaGame
//
//  Created by Luis on 6/5/24.
//
//  Bibliography:
//  https://github.com/luisebt995/APIExample
//  https://www.hackingwithswift.com/forums/swiftui/text-formatting/3796
//  Mastering SwiftUI - Chapter 15

import Foundation

/*Format to receive JSON from the API*/

struct DataAPI : Decodable {
    var response_code : Int
    var results : [QuestionAPI]
}

struct QuestionAPI : Decodable {
    var type : String
    var difficulty : String
    var category : String
    var question : String
    var correct_answer : String
    var incorrect_answers : [String]
}

// --------- //

/*Extension to String class to decode from from HTML format to ASCII format*/

extension String {
    var decoded: String {
        let attr = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil)

        return attr?.string ?? self
    }
}

