//
//  ReviewViewModel.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/10/02.
//

import Foundation
import FirebaseFirestore
import Combine

class ReviewViewModel: ObservableObject {
    @Published var tangoRepository = TangoRepository()
    @Published var tangos: [Tangos.Tango] = []
    
    @Published var gazeProgress =  0.0
    @Published var isFinish = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        // TangoRepositoryのtangosをこのクラスで定義したtangosに代入
        tangoRepository.$tangos.assign(to: \.tangos, on: self)
            .store(in: &cancellables)
    }
    
    // 進捗ゲージの加算
    func addGazeProgress(listCount: Int) {
        self.gazeProgress += 1 / Double(listCount)
        // 復習予定の全ての単語の終了時
        if(self.gazeProgress > 0.95){
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
