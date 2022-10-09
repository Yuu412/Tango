//
//  CoverImageExtension.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/25.
//
// extention for cover image used for Textbook etc.

import SwiftUI

extension Image {
    // 選択されていないカバー画像
    func coverImageExtension() -> some View {
        return self
            .resizable()
            .scaledToFit()
            .frame(
                idealWidth: CoverImageConstants.idealWidth,
                maxWidth: CoverImageConstants.maxWidth,
                minHeight: CoverImageConstants.height,
                idealHeight: CoverImageConstants.height,
                maxHeight: CoverImageConstants.height,
                alignment: .center
            )
            .aspectRatio(contentMode: .fill)
            .clipped()
            .background(BackgroundColor.background)
            .overlay(
                RoundedRectangle(cornerRadius: 7.5)
                    .stroke(BackgroundColor.darkBackground, lineWidth: 2)
            )
    }
    
    // 選択されたカバー画像
    func isSelectCoverImageExtension() -> some View {
        return self
            .resizable()
            .scaledToFit()
            .frame(
                idealWidth: CoverImageConstants.idealWidth,
                maxWidth: CoverImageConstants.maxWidth,
                minHeight: CoverImageConstants.height,
                idealHeight: CoverImageConstants.height,
                maxHeight: CoverImageConstants.height,
                alignment: .center
            )
            .aspectRatio(contentMode: .fill)
            .clipped()
            .background(BackgroundColor.background)
            .overlay(
                RoundedRectangle(cornerRadius: 7.5)
                    .stroke(BackgroundColor.blueBackground, lineWidth: 4)
            )
            .overlay(
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundColor(BackgroundColor.blueBackground)
                    .background(Color.white)
                    .cornerRadius(99)
                    .position(x: CoverImageConstants.idealWidth, y: 0)
            )
    }
    
    // 「登録済み単語」に表示されるカバー画像
    func registeredCoverImageExtension() -> some View {
        return self
            .resizable()
            .scaledToFit()
            .frame(
                idealWidth: RegisteredCoverImageConstants.idealWidth,
                maxWidth: RegisteredCoverImageConstants.maxWidth,
                minHeight: RegisteredCoverImageConstants.height,
                idealHeight: RegisteredCoverImageConstants.height,
                maxHeight: RegisteredCoverImageConstants.height,
                alignment: .center
            )
            .aspectRatio(contentMode: .fill)
            .clipped()
            .background(BackgroundColor.background)
            .overlay(
                RoundedRectangle(cornerRadius: 7.5)
                    .stroke(BackgroundColor.darkBackground, lineWidth: 5)
            )
    }
}
