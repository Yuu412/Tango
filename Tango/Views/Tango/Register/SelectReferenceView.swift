//
//  SelectReferenceView.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/24.
//
// Parent: SelectReferenceTypeView

import SwiftUI

struct SelectReferenceView: View {
    
    @EnvironmentObject var registerVM: RegisterViewModel
    @StateObject var referenceVM = ReferenceViewModel()
    
    // 「<戻る」処理を行うための変数
    @Environment(\.presentationMode) var presentation
    
    var body: some View{
        
        VStack {
            // 「参照元を選択」
            Text("参照元を選択")
                .modifier(SectionTitle())
                .padding(.vertical, 15)
            
            //カバー画像 表示部
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(referenceVM.references) { reference in
                        VStack(spacing: 5) {
                            // 参照元のカバー画像
                            if registerVM.referenceID == reference.id {
                                // 選択されたカバー画像の場合
                                Image(uiImage: reference.image)
                                    .isSelectCoverImageExtension()
                                
                            } else {
                                // 選択されていないカバー画像の場合
                                Image(uiImage: reference.image)
                                    .coverImageExtension()
                            }
                            
                            // 参照元のタイトル
                            Text(reference.title)
                                .modifier(ReferenceTitle())
                            
                            Spacer()
                        }
                        .padding(.horizontal, 10)
                        .onTapGesture {
                            // 登録用VMの参照元IDにFirebaseから取得した参照元IDを代入
                            registerVM.referenceID = reference.id
                            registerVM.referenceTitle = reference.title
                        }
                        
                    }
                }
                .padding(.top, 15)
                .offset(x: 20)
            }
        }
        
        // View: メモを記入するフォーム
        ReferenceMemoView()
        
        VStack {
            Spacer()
            
            // 入力チェック
            if registerVM.referenceID.isEmpty {
                // 参照元の選択を促す
                Text("参照元を選択してください")
                    .modifier(DefaultButtonWithDescription(color: Color.gray))
                
                // 参照元を追加する場合は一つ前のページに戻る
                Text("参照元を登録する")
                    .foregroundColor(TextColor.blue)
                    .onTapGesture {
                        // 「戻る」処理
                        self.presentation.wrappedValue.dismiss()
                    }
                    .padding(.bottom, 20)
            } else {
                // 「次へ」ボタン：活性
                NavigationLink(destination: ConfirmRegisterView()) {
                    Text("次へ")
                        .modifier(DefaultButton(color: Color.blue))
                }
                .padding(.bottom, 20)
            }
        }
        .frame(height: FrameSize().height * 0.2)
        
    }
}


struct ReferenceMemoView: View {
    @EnvironmentObject var registerVM: RegisterViewModel
    
    var body: some View{
        // メモの追記欄
        Form {
            HStack {
                Text("メモ1")
                    .frame(width: FrameSize().width * 0.2, alignment: .leading)
                TextField(text: $registerVM.memo1, prompt: Text("任意（例：ページ数）")) {}
                
            }
            HStack{
                Text("メモ2")
                    .frame(width: FrameSize().width * 0.2, alignment: .leading)
                TextField(text: $registerVM.memo2, prompt: Text("任意（例：品詞）")) {}
            }
        }
    }
}
