//
//  TangoRepository.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/26.
//

import Foundation
import FirebaseFirestore

final class TangoRepository: ObservableObject {
    private let db = Firestore.firestore()
    private let table = "tangos"
    
    //@Published var tangos = [Tangos.Tango]()
    @Published var tangos: [Tangos.Tango] = []
    
    init() {
        getData()
    }
    
    func getData() {
        db.collection(table).getDocuments{ snapshot, error in
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
                                enName: doc["enName"] as? String ?? "",
                                jaName: doc["jaName"] as? String ?? "",
                                enSentence: doc["enSentence"] as? String ?? "",
                                jaSentence: doc["jaSentence"] as? String ?? "",
                                referenceID: doc["referenceID"] as? String ?? "",
                                memo1: doc["memo1"] as? String ?? "",
                                memo2: doc["memo2"] as? String ?? ""
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
    func registerTango(tango: Tangos.Tango) {
        // Save a reference to the file in FireStore DB
        let db = Firestore.firestore()
        db.collection("references")
            .document()
            .setData([
                "enTango": tango.enName,
                "jaTango": tango.jaName,
                "enSentence": tango.enSentence,
                "jaSentence": tango.jaSentence,
                "referenceID": tango.referenceID,
                "memo1": tango.memo1,
                "memo2": tango.memo2,
            ])
        
    }
}
