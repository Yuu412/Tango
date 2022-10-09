//
//  TangoScreenViewModel.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/10/06.
//

import Foundation
import FirebaseFirestore
import Combine

class TangoScreenViewModel: ObservableObject {
    
    @Published var tangoScreenRepository = TangoScreeenRepository()
    @Published var references: [References.ListedReference] = []
    
    // 「単語一覧」の展開を示すリスト
    @Published var isToggleDict: [String: Bool] = [:]
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        // repositoryでFirebaseから取得したリストを取得
        tangoScreenRepository.$references.assign(to: \.references, on: self)
            .store(in: &cancellables)
        
        // repositoryから展開用のdictを取得
        tangoScreenRepository.$isToggleDict.assign(to: \.isToggleDict, on: self)
            .store(in: &cancellables)
    }
    
    // 展開する「単語一覧」を設定する関数
    func setToggleState(referenceID: String) {
        // nil check
        guard let isToggle = isToggleDict[referenceID] else {
            // Handle the error
            return
        }
        
        // dict内の展開フラグのstate変更
        if isToggle {
            // 現時点でdict内の値がtrue(=展開済み)の場合
            self.isToggleDict.updateValue(false, forKey: referenceID)
        } else {
            // 現時点でdict内の値がfalse(=未展開)の場合
            self.isToggleDict.updateValue(true, forKey: referenceID)
        }
    }
}

