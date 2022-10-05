//
//  ButtonModifier.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/24.
//

import SwiftUI

// defaultボタン
// ※ textに対して付与すること
struct DefaultButton: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(TextColor.reverse)
            .frame(width: FrameSize().width * 0.8)
            .padding(.horizontal, 15)
            .padding(.vertical, 12.5)
            .background(color)
            .cornerRadius(10)
    }
}

// ※ textに対して付与すること
struct DefaultButtonWithDescription: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(TextColor.reverse)
            .frame(width: FrameSize().width * 0.8)
            .padding(.horizontal, 15)
            .padding(.vertical, 12.5)
            .background(color)
            .cornerRadius(10)
    }
}

// 左右半分のボタン
struct HalfButton: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(TextColor.reverse)
            .padding(.horizontal, 15)
            .padding(.vertical, 7.5)
            .frame(width: FrameSize().width * 0.4)
            .background(color)
            .cornerRadius(5)
    }
}

// カバー画像が左にあって、左右半分のボタン
struct RightHalfButton: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(TextColor.reverse)
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .frame(width: FrameSize().width / 4)
            .background(color)
            .cornerRadius(5)
    }
}

