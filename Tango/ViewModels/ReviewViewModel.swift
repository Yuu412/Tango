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
    @Published var gazeProgress =  0.0
    @Published var isFinish = false
    
    init() {
        getData()
    }
  
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
    
    // 進捗ゲージの加算
    func addGazeProgress(listCount: Int) {
        self.gazeProgress += 1 / Double(listCount)
        // 復習予定の全ての単語の終了時
        if(self.gazeProgress >= 1){
            self.finish()
        }
    }
    
    // 進捗ゲージの減算
    func subGazeProgress(listCount: Int) {
        self.gazeProgress -= 1 / Double(listCount)
    }
    
    // 復習終了フラグの真偽値変更
    func finish() {
        self.isFinish = true
    }
}
