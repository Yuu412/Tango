//
//  HomeActivityViewModel.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/10/02.
//
import Foundation
import Combine

struct ProfitOverTime: Identifiable{
    var id = UUID()
    var date: Date
    var profit: Double
}

// String型 -> Date型
func StringToDate(dateValue: String, format: String) -> Date {
       let dateFormatter = DateFormatter()
       dateFormatter.calendar = Calendar(identifier: .gregorian)
       dateFormatter.dateFormat = format
       return dateFormatter.date(from: dateValue) ?? Date()
   }

class HomeActivityViewModel: ObservableObject {
    @Published var dateArray = [
        ProfitOverTime(date: StringToDate(dateValue: "2022/10/01", format: "yyyy/MM/dd"), profit: 15),
        ProfitOverTime(date: StringToDate(dateValue: "2022/10/02", format: "yyyy/MM/dd"), profit: 52),
        ProfitOverTime(date: StringToDate(dateValue: "2022/10/03", format: "yyyy/MM/dd"), profit: 40),
        ProfitOverTime(date: StringToDate(dateValue: "2022/10/04", format: "yyyy/MM/dd"), profit: 50),
        ProfitOverTime(date: StringToDate(dateValue: "2022/10/05", format: "yyyy/MM/dd"), profit: 20),
        ProfitOverTime(date: StringToDate(dateValue: "2022/10/06", format: "yyyy/MM/dd"), profit: 30),
        ProfitOverTime(date: StringToDate(dateValue: "2022/10/07", format: "yyyy/MM/dd"), profit: 42),
        ProfitOverTime(date: StringToDate(dateValue: "2022/10/08", format: "yyyy/MM/dd"), profit: 23),
        ProfitOverTime(date: StringToDate(dateValue: "2022/10/09", format: "yyyy/MM/dd"), profit: 36),
        ProfitOverTime(date: StringToDate(dateValue: "2022/10/10", format: "yyyy/MM/dd"), profit: 23),
    ]
    
    @Published var tangoRepository = TangoRepository()
    @Published var tangos: [Tangos.Tango] = []
    @Published var tangoAmounts: [Tangos.TangoAmount] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        // TangoRepositoryのtangosをこのクラスで定義したtangosに代入
        tangoRepository.$tangos.assign(to: \.tangos, on: self)
            .store(in: &cancellables)
    }
    
}
