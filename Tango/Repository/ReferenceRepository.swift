//
//  ReferenceRepository.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/26.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

final class ReferenceRepository: ObservableObject {
    private let db = Firestore.firestore()
    private let table = "references"
    
    // defaultのカバー画像の設定
    private let defaultImage = UIImage(named: "referenceExample")!
    
    @Published var references: [References.Reference] = []
    
    init() {
        getData()
    }
    
    // String型からDate型への型変換（キャスト）
    func StringToDate(dateValue: String, format: String) -> Date {
           let dateFormatter = DateFormatter()
           dateFormatter.calendar = Calendar(identifier: .gregorian)
           dateFormatter.dateFormat = format
           return dateFormatter.date(from: dateValue) ?? Date()
       }
    
    // Firebaseからの情報取得
    func getData() {
        db.collection(table).getDocuments{ snapshot, error in
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
                    
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        // Check for errors
                        
                        if error == nil && data != nil {
                            
                            // 明日確認
//                            let coverImage: UIImage
//                            if let image = UIImage(data: data!){
//                                coverImage = image
//                            } else {
//                                coverImage = self.defaultImage
//                            }
                        
                            
                            
                            
                            
                            // Create a UIImage
                            if let image = UIImage(data: data!) {
                                DispatchQueue.main.async {
                                    self.references.append(
                                        References.Reference(
                                            id: doc.documentID,
                                            userID: doc["userID"] as? String ?? "",
                                            title: doc["title"] as? String ?? "",
                                            label: doc["label"] as? String ?? "",
                                            image: image,
                                            createdAt: doc["createdAt"] as? Date ?? Date(),
                                            updatedAt: doc["updatedAt"] as? Date ?? Date()
                                        )
                                    )
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.references.append(
                                        References.Reference(
                                            id: doc.documentID,
                                            userID: doc["userID"] as? String ?? "",
                                            title: doc["title"] as? String ?? "",
                                            label: doc["label"] as? String ?? "",
                                            image: self.defaultImage,
                                            createdAt: doc["createdAt"] as? Date ?? Date(),
                                            updatedAt: doc["updatedAt"] as? Date ?? Date()
                                        )
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Firebaseへの情報追加
    func addData(title: String, label: String, image: UIImage?) {
        // ログインユーザーの取得
        guard let user = Auth.auth().currentUser else {
            print("need sign in")
            return
        }
        
        // nil check
        guard let unwrapImage = image else {
            // Save a reference to the file in FireStore DB
            db.collection(table)
                .document()
                .setData([
                    "userID": user.uid,
                    "title": title,
                    "label": label,
                    "url": "",
                    "createdAt": Date(),
                    "updatedAt": Date()
                ])
            return
        }
        
        // Create storage reference
        let storageRef = Storage.storage().reference()
        
        // Turn our image into data
        let imageData = unwrapImage.jpegData(compressionQuality: 0.25)
        
        // Check that we were able to convert it to data
        guard imageData != nil else {
            return
        }
        
        // Specify the file path and name
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        // Upload that data
        fileRef.putData(imageData!, metadata: nil) { metadata, error in
            // Check for errors
            if error == nil && metadata != nil {
                
                // Save a reference to the file in FireStore DB
                let db = Firestore.firestore()
                db.collection("references")
                    .document()
                    .setData([
                        "userID": user.uid,
                        "title": title,
                        "label": label,
                        "url": path,
                        "createdAt": Date(),
                        "updatedAt": Date()
                    ])
            }
            
        }
    }
}
