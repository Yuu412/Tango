//
//  fontModifier.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/17.
//

import SwiftUI

struct PageTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(Font.TextStyle.largeTitle, weight: .bold))
    }
}

struct PageHeadline: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(Font.TextStyle.subheadline, weight: .bold))
            .foregroundColor(TextColor.light)
    }
}
 
struct SectionTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(Font.TextStyle.title, weight: .bold))
    }
}

struct ButtonTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(Font.TextStyle.callout, weight: .bold))
    }
}

