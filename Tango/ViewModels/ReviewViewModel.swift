//
//  ReviewViewModel.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/18.
//

import Foundation
import FirebaseFirestore

class ReviewViewModel: ObservableObject {
    @Published var tangoList = [Tangos.Tango]()
    @Published var gazeProgress = 0.1
  
    func getData() {
        // Get a referance to the database
        let db = Firestore.firestore()
        
        db.collection("tangos").getDocuments{ snapshot, error in
            // Check for errors
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        // Get all the documents and create Tangos
                        self.tangoList = snapshot.documents.map { d in
                            
                            //Create a Tango item for each document returned
                            return Tangos.Tango(
                                id: d.documentID,
                                enName: d["enName"] as? String ?? "",
                                jaName: d["jaName"] as? String ?? "",
                                enSentence: d["enSentence"] as? String ?? "",
                                jaSentence: d["jaSentence"] as? String ?? ""
                            )
                        }
                    }
                }
            } else {
                // Handle the error
            }
        }
    }
    
    func addGazeProgress(listCount: Int) {
        print(listCount)
        self.gazeProgress += Double(1 / listCount)
    }
    
    func subGazeProgress(listCount: Int) {
        self.gazeProgress -= Double(1 / listCount)
    }
    
    init() {
        getData()
    }

}
