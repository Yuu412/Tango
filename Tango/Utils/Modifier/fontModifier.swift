//
//  FontModifier.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/24.
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

struct PageDescription: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(Font.TextStyle.subheadline, weight: .bold))
            .foregroundColor(TextColor.light)
            .multilineTextAlignment(.center)
            .frame(width: FrameSize().width * 0.7)
    }
}

struct UnderContentDescription: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(Font.TextStyle.callout, weight: .bold))
            .foregroundColor(TextColor.blue)
            .multilineTextAlignment(.center)
            .frame(width: FrameSize().width * 0.7)
    }
}

struct ReferenceTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(Font.TextStyle.footnote, weight: .medium))
            .foregroundColor(TextColor.light)
            .multilineTextAlignment(.center)
            .frame(width: CoverImageConstants.idealWidth)
            .lineLimit(2)
    }
}


