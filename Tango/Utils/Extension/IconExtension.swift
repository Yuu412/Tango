//
//  IconExtension.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/24.
//

import SwiftUI

extension Image {
    // 画面右上に表示されるアイコン
    func topRightIconExtension() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 25)
            .foregroundColor(BackgroundColor.blueBackground)
    }
    
    // リスト形式の左端に表示されるアイコン
    func listBlueIconExtension() -> some View {
        self
            .resizable()
            .scaledToFit()
            .foregroundColor(Color.blue)
            .frame(width: 25)
            .padding(.trailing, 10)
    }
    
    func contentBlueIconExtension() -> some View {
        self
            .resizable()
            .scaledToFit()
            .foregroundColor(Color.blue)
            .frame(width: 40)
            .padding(.trailing, 10)
    }
    
    // 画面のトップに表示されるアイコン
    func pageTopIconExtension() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: FrameSize().width * 0.15)
            .foregroundColor(BackgroundColor.blueBackground)
            .padding(.vertical, 20)
    }
}
