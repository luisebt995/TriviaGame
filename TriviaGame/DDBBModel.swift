//
//  DDBBModel.swift
//  TriviaGame
//
//  Created by Luis on 9/5/24.
//
//  Bibliography:
//  Swift UI Firebase - Chapter 3

import Foundation
import FirebaseFirestoreSwift

struct UserData: Codable {
    //Primary Key
    @DocumentID var id: String?
    
    //Keep track score player
    var corrects: Int?
    var incorrects: Int?
    var ratio: Double?
    
}
