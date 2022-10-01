//
//  RegisterTangoView.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/24.
//
// Parent: TangoScreen

import SwiftUI

struct RegisterTangoView: View{
    @EnvironmentObject var registerVM: RegisterViewModel
    
    var body: some View{
        NavigationView {
            VStack(spacing: 15){
                
                // 画面を閉じるための目印
                VStack{
                    Rectangle().modifier(CloseSheetRectangle())
                }
                .padding(.vertical, 20)
                
                // 単語のロゴ
                Image(systemName: "textformat")
                    .pageTopIconExtension()
                
                // 「単語を追加」
                Text("単語を追加")
                    .modifier(SectionTitle())
                    .padding(.vertical, 10)
                
                Text("キーボードから入力するか、テキストスキャンから英単語をスキャンできます。")
                    .modifier(PageDescription())
                
                
                Spacer()
                
                Form {
                    HStack {
                        Text("英単語")
                            .frame(width: FrameSize().width * 0.2, alignment: .leading)
                        TextField(text: $registerVM.enTango, prompt: Text("必須")) {}
                        
                    }
                    HStack{
                        Text("意味")
                            .frame(width: FrameSize().width * 0.2, alignment: .leading)
                        TextField(text: $registerVM.jaTango, prompt: Text("必須")) {}
                    }
                }
                
                // 入力チェック
                if(registerVM.isSetEmpty(a: registerVM.enTango, b: registerVM.jaTango)) {
                    // 「次へ」ボタン：活性
                    NavigationLink(destination: RegisterSentenceView()) {
                        Text("次へ")
                            .modifier(DefaultButton(color: Color.blue))
                    }
                    .padding(.bottom, 20)
                } else {
                    // 「次へ」ボタン：非活性
                    Text("英単語を入力してください")
                        .modifier(DefaultButton(color: Color.gray))
                        .padding(.bottom, 20)
                }
                
            }
        }
    }
    
}
