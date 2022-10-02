//
//  TypeConversionFunction.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/10/02.
//

import Foundation

// 型変換を行うためのクラス
class TypeConversion {
    // String型 -> Date型
    func StringToDate(dateValue: String, format: String) -> Date {
           let dateFormatter = DateFormatter()
           dateFormatter.calendar = Calendar(identifier: .gregorian)
           dateFormatter.dateFormat = format
           return dateFormatter.date(from: dateValue) ?? Date()
       }
}
