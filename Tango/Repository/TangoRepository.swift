//
//  TangoRepository.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/26.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class TangoRepository: ObservableObject {
    private let db = Firestore.firestore()
    private let table = "tangos"
    
    //@Published var tangos = [Tangos.Tango]()
    @Published var tangos: [Tangos.Tango] = []
    
    init() {
        getData()
    }
    
    func getData() {
        // ログインユーザーの取得
        guard let user = Auth.auth().currentUser else {
            print("need sign in")
            return
        }
        
        db.collection(table).whereField("userID", isEqualTo: user.uid).getDocuments{ snapshot, error in
            // Check for errors
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        // Get all the documents and create Tangos
                        self.tangos = snapshot.documents.map { doc in
                            //Create a Tango item for each document returned
                            return Tangos.Tango(
                                id: doc.documentID,
                                userID: doc["userID"] as? String ?? "",
                                enName: doc["enName"] as? String ?? "",
                                jaName: doc["jaName"] as? String ?? "",
                                enSentence: doc["enSentence"] as? String ?? "",
                                jaSentence: doc["jaSentence"] as? String ?? "",
                                referenceID: doc["referenceID"] as? String ?? "",
                                memo1: doc["memo1"] as? String ?? "",
                                memo2: doc["memo2"] as? String ?? "",
                                createdDate: doc["createdDate"] as? String ?? "",
                                createdAt: doc["createdAt"] as? Date ?? Date(),
                                updatedAt: doc["updatedAt"] as? Date ?? Date()
                            )
                        }
                    }
                }
            } else {
                // Handle the error
            }
        }
    }
    
    // Firebaseに情報追加
    func registerTango(enName: String, jaName: String, enSentence: String, jaSentence: String, referenceID: String, memo1: String, memo2: String) {
        
        // ログインユーザーの取得
        guard let user = Auth.auth().currentUser else {
            print("need sign in")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        let now: Date = Date()
        let today: String = dateFormatter.string(from: now)
        
        // Save a reference to the file in FireStore DB
        let db = Firestore.firestore()
        db.collection(table)
            .document()
            .setData([
                "userID": user.uid,
                "enName": enName,
                "jaName": jaName,
                "enSentence": enSentence,
                "jaSentence": jaSentence,
                "referenceID": referenceID,
                "memo1": memo1,
                "memo2": memo2,
                "createdDate": today,
                "createdAt": now,
                "updatedAt": now
            ])
        
    }
}
