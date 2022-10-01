//
//  RegisterViewModel.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/24.
//

import Foundation
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    @Published var enTango = "" // 英単語
    @Published var jaTango = "" // 英単語（和訳）
    @Published var enSentence = "" // 例文
    @Published var jaSentence = "" // 例文（和訳）
    @Published var referenceID = "" // 参照元のID
    @Published var referenceTitle = "" // 参照元のタイトル
    @Published var memo1 = "" // メモ1
    @Published var memo2 = "" // メモ2
    
    // sheetの開閉
    @Published var isModal: Bool = false
    
    // 英単語の入力時の処理
    func isSetEmpty(a:String, b:String) -> Bool{
        if a.isEmpty || b.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    // TangoをFireStore DBに登録
    func registerTango() {
        // Save a reference to the file in FireStore DB
        let db = Firestore.firestore()
        db.collection("tangos")
            .document()
            .setData([
                "enName": enTango,
                "jaName": jaTango,
                "enSentence": enSentence,
                "jaSentence": jaSentence,
                "referenceID": self.referenceID,
                "memo1": self.memo1,
                "memo2": self.memo2,
            ])
    }
    
    
}
