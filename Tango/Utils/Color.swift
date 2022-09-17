//
//  Color.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/17.
//

import SwiftUI

struct BackgroundColor{
    // 背景色（base）
    static let background = Color(UIColor.systemBackground)
    
    // 背景色（dark）
    static let darkBackground = Color("CardBackgroundColor")
    
    // 背景色（light）
    static let lightBackground = Color("ButtonLightColor")
    
    // 背景色（blue）
    static let blueBackground = Color.blue
}

struct TextColor {
    // light
    static let light = Color("LightTextColor")
    
    // dark
    
    // reverse
    static let reverse = Color("ReverseTextColor")
}
