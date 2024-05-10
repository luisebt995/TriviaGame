//
//  DDBBViewModel.swift
//  TriviaGame
//
//  Created by Luis on 9/5/24.
//
//  Bibliography:
//  Swift UI Firebase - Chapter 3

import SwiftUI
import FirebaseFirestore

class DDBBViewModel: ObservableObject {
    
    @Published var userData:[UserData] = []
    @Published var selectedData : UserData?
    
    private var databaseReference = Firestore.firestore().collection("UserData")

    //Function to post data
    func addData(corrects: Int, incorrects: Int, ratio: Double) {
        do {
            _ = try databaseReference.addDocument(from: UserData(corrects: corrects, incorrects: incorrects, ratio: ratio))
        }
        catch {
            print(error.localizedDescription)
        }
    }

    //Function to read data
    func fetchData() {
        databaseReference.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.userData = documents.compactMap {
                queryDocumentSnapshot -> UserData? in
                    return try? queryDocumentSnapshot.data(as: UserData.self)

            }
        }
    }

    //Function to update data
    func updateData() {
        if let userDataID = selectedData?.id {
            databaseReference.document(userDataID).updateData(["corrects" : 0])
        }
    }
    

    //Function to delete data
    //See DDBBView to understand "(at indexSet : IndexSet)"
    func deleteData(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let userData = userData[index]
            databaseReference.document(userData.id ?? "").delete { error in
                if let error = error {
                    print("\(error.localizedDescription)")
                } else {
                    print("Note with ID \(userData.id ?? "") deleted")
                }
            }
        }
    }
}
