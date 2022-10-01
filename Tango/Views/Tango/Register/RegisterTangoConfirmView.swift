//
//  RegisterTangoConfirmView.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/25.
//
// Parent: RegisterReferenceView or SelectReferenceView

import SwiftUI

struct RegisterTangoConfirmView: View {
    
    @EnvironmentObject var registerVM: RegisterViewModel
    
    var body: some View{
        VStack(spacing: 15){
            
            // 単語のロゴ
            Image(systemName: "textformat")
                .pageTopIconExtension()
            
            // 「参照元を追加」
            Text("単語を登録")
                .modifier(SectionTitle())
                .padding(.vertical, 10)
            
            Text("以下に記載の内容で間違いがない場合は、「登録」を押下してください。")
                .modifier(PageDescription())
            
            Spacer()
            
            // 「登録」ボタン：活性
            NavigationLink(destination: SelectReferenceTypeView()) {
                Text("登録")
                    .modifier(DefaultButton(color: Color.blue))
            }
            .simultaneousGesture(TapGesture().onEnded {
                // 登録：単語の登録
                registerVM.registerTango()
            })
            .padding(.vertical, 20)
        }
    }
}
