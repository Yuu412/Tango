//
//  Tango.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/18.
//

import Foundation

struct Tangos {
    // Firestore上のデータ形式
    struct Tango: Identifiable {
        var id: String
        var enName: String
        var jaName: String
        var enSentence: String
        var jaSentence: String
    }
    
}

