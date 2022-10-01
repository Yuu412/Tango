//
//  RegisterSentenceView.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/24.
//
// Parent: RegisterTangoView

import SwiftUI

struct RegisterSentenceView: View {
    
    @EnvironmentObject var registerVM: RegisterViewModel
    
    var body: some View{
        VStack(spacing: 15){
            
            // ページ先頭部のアイコン
            Image(systemName: "text.bubble")
                .pageTopIconExtension()
            
            Text("例文を追加")
                .modifier(SectionTitle())
                .padding(.vertical, 10)
            
            Text("キーボードから入力するか、テキストスキャンから例文をスキャンできます。")
                .modifier(PageDescription())
            
            Spacer()
            
            Form {
                HStack {
                    Text("例文")
                        .frame(width: FrameSize().width * 0.2, alignment: .leading)
                    TextField(text: $registerVM.enSentence, prompt: Text("任意")) {}
                    
                }
                HStack{
                    Text("和訳")
                        .frame(width: FrameSize().width * 0.2, alignment: .leading)
                    TextField(text: $registerVM.jaSentence, prompt: Text("任意")) {}
                }
            }
            
            // 入力チェック
            if(registerVM.isSetEmpty(a: registerVM.enSentence, b: registerVM.jaSentence)) {
                // 「次へ」ボタン：活性
                NavigationLink(destination: SelectReferenceTypeView()) {
                    Text("次へ")
                        .modifier(DefaultButton(color: Color.blue))
                }
                .padding(.vertical, 20)
            } else {
                // 例文の追加をスキップ
                NavigationLink(destination: SelectReferenceTypeView()) {
                    Text("例文の追加をスキップ")
                        .modifier(DefaultButton(color: Color.gray))
                }
                .padding(.vertical, 20)
            }
            

        }
    }
}

