//
//  Tango.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/18.
//

import Foundation
import FirebaseFirestore

struct Tangos {
    // Firestore上のデータ形式
    struct Tango: Identifiable {
        var id: String
        var enName: String
        var jaName: String
        var enSentence: String
        var jaSentence: String
        var referenceID: String
        var memo1: String
        var memo2: String
    }
}
