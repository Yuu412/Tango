//
//  TangoScreenRepositry.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/10/06.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

final class TangoScreeenRepository: ObservableObject {
    private let db = Firestore.firestore()
    private let referenceTableName = "references"
    private let tangoTableName = "tangos"
    
    // 参照元リストの参照元一覧
    @Published var references: [References.ListedReference] = []
    
    //「単語一覧」の展開を示すリスト
    @Published var isToggleDict: [String: Bool] = [:]
    
    // defaultのカバー画像の設定
    private let defaultImage = UIImage(named: "referenceExample")!
    
    init() {
        getReferenceData()
    }
    
    // Firebaseから参照元リストを取得後、その参照元に紐づく単語リストを取得
    func getReferenceData() {
        
        // ログインユーザーの取得
        guard let user = Auth.auth().currentUser else {
            print("need sign in")
            return
        }
        
        db.collection(referenceTableName).whereField("userID", isEqualTo: user.uid).getDocuments{ snapshot, error in
            // Check for errors
            if error == nil && snapshot != nil{
                // No errors
                
                // Loop
                for doc in snapshot!.documents {
                    let imagePath = doc["url"] as! String
                    
                    // Firebase Storage への参照を取得
                    let storageRef = Storage.storage().reference()
                    
                    // Create a reference to the file you want to download
                    let fileRef = storageRef.child(imagePath)
                    
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { imageData, error in
                        // Check for errors
                        if error != nil {
                            // Handle the error
                        }
                        
                        // nil check
                        guard let unwrapImageData = imageData else {
                            // Handle the error
                            return
                        }
                        
                        // defaultのカバー画像でcoverImageを初期化
                        var coverImage: UIImage = self.defaultImage
                        
                        // nil check
                        if let image = UIImage(data: unwrapImageData){
                            coverImage = image
                        }
                        
                        // 参照元に紐づく単語一覧を取得
                        self.db.collection(self.tangoTableName)
                            .whereField("userID", isEqualTo: user.uid)
                            .whereField("referenceID", isEqualTo: doc.documentID)
                            .getDocuments { snapshot, error in
                                // Check for errors
                                if error != nil {
                                    // Handle the error
                                }
                                // No errors
                                
                                if let snapshot = snapshot {
                                    // Get all the documents and create Tangos
                                    self.references.append(
                                        References.ListedReference(
                                            id: doc.documentID,
                                            userID: doc["userID"] as? String ?? "",
                                            title: doc["title"] as? String ?? "",
                                            label: doc["label"] as? String ?? "",
                                            image: coverImage,
                                            createdAt: doc["createdAt"] as? Date ?? Date(),
                                            updatedAt: doc["updatedAt"] as? Date ?? Date(),
                                            tangos: snapshot.documents.map { doc in
                                                //Create a Tango item for each document returned
                                                return Tangos.ListedTango(
                                                    id: doc.documentID,
                                                    enName: doc["enName"] as? String ?? "",
                                                    jaName: doc["jaName"] as? String ?? ""
                                                )
                                            }
                                        )
                                    )
                                    
                                    // 展開する「単語一覧」の辞書を作成
                                    self.isToggleDict.updateValue(false, forKey: doc.documentID)
                                }
                            }
                    }
                }
            }
        }
    }
}
