//
//  ConfirmRegisterView.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/10/01.
//

import SwiftUI

struct ConfirmRegisterView: View {
    @EnvironmentObject var registerVM: RegisterViewModel
    
    // 環境変数の取得
    @Environment (\.isPresentingModal) var isPresentedModally
    
    var body: some View{
        VStack(spacing: 15){
            
            // ページ先頭部のアイコン
            Image(systemName: "plus.app")
                .pageTopIconExtension()
            
            Text("登録内容の確認")
                .modifier(SectionTitle())
                .padding(.vertical, 10)
            
            Spacer()
            
            // Tanogの情報の確認箇所
            ConfirmTangoView()
            
            // 「登録」ボタン：活性
            Button(action: {
                // Tangoの情報をFirebaseに登録
                registerVM.registerTango()
                // 環境変数に対して状態変更を適応
                isPresentedModally.wrappedValue = false
            }, label: {
                Text("登録")
                    .modifier(DefaultButton(color: Color.blue))
            })
            .padding(.vertical, 20)
        }
    }
}


struct ConfirmTangoView: View {
    @EnvironmentObject var registerVM: RegisterViewModel
    
    var body: some View{
        VStack(spacing: 20){
            // 「英単語」
            HStack(spacing: 5) {
                // チェックマークのアイコン
                Image(systemName: "checkmark.circle")
                    .contentBlueIconExtension()
                
                // 「英単語」の登録情報
                VStack(alignment: .leading) {
                    Text("英単語")
                    Text("\(registerVM.enTango)(\(registerVM.jaTango))")
                        .font(.system(Font.TextStyle.callout, weight: .bold))
                        .foregroundColor(TextColor.light)
                        .padding(.top, 2.5)
                }
                Spacer()
            }
            .frame(width: FrameSize().width * 0.8)
            
            // 「例文」
            if !registerVM.enSentence.isEmpty {
                HStack(spacing: 5) {
                    // チェックマークのアイコン
                    Image(systemName: "checkmark.circle")
                        .contentBlueIconExtension()
                    
                    // 「英単語」の登録情報
                    VStack(alignment: .leading) {
                        Text("例文")
                        Text("\(registerVM.enSentence)")
                            .font(.system(Font.TextStyle.callout, weight: .bold))
                            .foregroundColor(TextColor.light)
                            .padding(.top, 2.5)
                    }
                    Spacer()
                }
                .frame(width: FrameSize().width * 0.8)
            }
            
            // 「例文」
            if !registerVM.enSentence.isEmpty {
                HStack(spacing: 5) {
                    // チェックマークのアイコン
                    Image(systemName: "checkmark.circle")
                        .contentBlueIconExtension()
                    
                    // 「英単語」の登録情報
                    VStack(alignment: .leading) {
                        Text("参照元")
                        Text("\(registerVM.referenceTitle)")
                            .font(.system(Font.TextStyle.callout, weight: .bold))
                            .foregroundColor(TextColor.light)
                            .padding(.top, 2.5)
                    }
                    Spacer()
                }
                .frame(width: FrameSize().width * 0.8)
            }
            Spacer()
        }
    }
}

