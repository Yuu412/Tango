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

struct CloseSheetRectangle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.gray)
            .frame(width: FrameSize().width * 0.1, height: 5)
            .cornerRadius(99)
            .foregroundColor(BackgroundColor.lightBackground)
    }
}

