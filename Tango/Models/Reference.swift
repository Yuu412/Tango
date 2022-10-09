//
//  Reference.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/25.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import PhotosUI

struct References {
    // Firestore上のデータ形式
    struct Reference: Identifiable {
        var id: String
        var userID: String
        var title: String
        var label: String
        var image: UIImage
        var createdAt: Date
        var updatedAt: Date
    }
    
    // 登録済み単語の参照元リストに表示用の構造体
    struct ListedReference: Identifiable{
        var id: String
        var userID: String
        var title: String
        var label: String
        var image: UIImage
        var createdAt: Date
        var updatedAt: Date
        var tangos: [Tangos.ListedTango]
    }
}
    
