//
//  ViewModifier.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/17.
//

import SwiftUI

struct CardView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: FrameSize().width - 20)
            .background(BackgroundColor.darkBackground)
            .cornerRadius(10)
    }
}

// 左右半分のボタン
struct HalfButton: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 15)
            .padding(.vertical, 7.5)
            .foregroundColor(TextColor.reverse)
            .frame(width: FrameSize().width * 0.4)
            .background(color)
            .cornerRadius(5)
    }
}
