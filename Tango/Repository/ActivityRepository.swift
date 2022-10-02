//
//  ActivityRepository.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/10/02.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class ActivityRepository: ObservableObject {
    private let db = Firestore.firestore()
    private let table = "tangos"
    
    @Published var tangos: [Tangos.Tango] = []
    @Published var tangoAmounts: [Tangos.TangoAmount] = []
    
    // 登録した単語数の合計
    @Published var tangoAmountSum = 0
    
    init() {
        getData()
    }
    
    // Firebaseから単語リストを取得後、日付ごとの単語登録量を計算し、tangoAmountsに格納
    func getData() {
        // ログインユーザーの取得
        guard let user = Auth.auth().currentUser else {
            print("need sign in")
            return
        }
        
        db.collection(table).whereField("userID", isEqualTo: user.uid).getDocuments {
            snapshot, error in
            // Check for errors
            if error != nil {
                // Handle the error
            }
            
            // No errors
            guard let snapshot = snapshot else {
                return
                // Handle the error
            }
            
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
            
            // tanogos から活動記録表示用のデータ（Tangos.TangoAmount）を生成
            self.makeAmountList()
        }
    }
    
    // 活動記録のグラフに使用する構造体（Tanogs.TangoAmount）の配列を生成
    func makeAmountList() {
        // 配列に挿入された日付のリスト
        var isDate: [String] = []
        for tango in self.tangos {
            
            // String型をDate型に変換
            let date = TypeConversion().StringToDate(dateValue: tango.createdDate, format: "yyyy/MM/dd")
            
            // 探索済みの日付に、dateが含まれるか否か
            if isDate.contains(tango.createdDate) {
                // 探索済みの日付に合致する構造体を探し、元の構造体を削除した後、更新後データを挿入
                deleteAppendAmount(date: date)
            
            } else {
                isDate.append(tango.createdDate)
                self.tangoAmounts.append( Tangos.TangoAmount(
                    date: date,
                    amount: 1
                ))
            }
            self.tangoAmounts.sort(by: {$0.date < $1.date})
        }
        
        // 登録単語の総数を計算
        tangoAmounts.forEach { tangoAmount in
            self.tangoAmountSum += tangoAmount.amount
        }
    }
    
    // 探索済みの日付に合致する構造体を探し、元の構造体を削除した後、更新後データを挿入
    func deleteAppendAmount(date: Date) {
        let targetData = self.tangoAmounts.first(where: {
            $0.date == date
        })
        
        // nil check
        guard var unwrapTargetData = targetData else {
            // Handle the error
            return
        }
        
        // 元の構造体のインデックスを検索
        guard let index = self.tangoAmounts.firstIndex(of: unwrapTargetData) else {
            // Handle the error
            return
        }
        
        // 元の構造体を削除
        self.tangoAmounts.remove(at: index)

        // 単語量を変更
        unwrapTargetData.amount = unwrapTargetData.amount + 1
        
        // 新しい値を代入
        self.tangoAmounts.append(unwrapTargetData)
    }
}
