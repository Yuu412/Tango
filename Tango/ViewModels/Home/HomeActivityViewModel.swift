//
//  HomeActivityViewModel.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/10/02.
//

import Foundation
import Combine

class HomeActivityViewModel: ObservableObject {
    @Published var activityRepository = ActivityRepository()
    @Published var tangos: [Tangos.Tango] = []
    @Published var tangoAmounts: [Tangos.TangoAmount] = []
    
    @Published var tangoAmountsSum: Int = 0
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        // ActivityRepositoryのtangoAmountsをこのクラスで定義したtangoAmountsに代入
        activityRepository.$tangoAmounts.assign(to: \.tangoAmounts, on: self)
            .store(in: &cancellables)
        
        // ActivityRepositoryのtangoAmountsSumをこのクラスで定義したtangoAmountsSumに代入
        activityRepository.$tangoAmountSum.assign(to: \.tangoAmountsSum, on: self)
            .store(in: &cancellables)
    }
    
}
