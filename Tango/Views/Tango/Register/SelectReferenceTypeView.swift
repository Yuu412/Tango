//
//  SelectReferenceTypeView.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/24.
//
// Parent: RegisterSentenceView

import SwiftUI

struct SelectReferenceTypeView: View {
    
    @EnvironmentObject var registerVM: RegisterViewModel
    
    var body: some View{
        VStack(spacing: 15){
            
            // 参照元のロゴ
            Image(systemName: "increase.quotelevel")
                .pageTopIconExtension()
            
            // 「参照元を追加」
            Text("参照元を追加")
                .modifier(SectionTitle())
                .padding(.vertical, 10)
            
            Text("英単語が記載されていた参考書などの参照元を追加できます。")
                .modifier(PageDescription())
            
            Spacer()
            
            Form {
                HStack {
                    Image(systemName: "folder")
                        .listBlueIconExtension()
                    
                    NavigationLink(destination: SelectReferenceView()) {
                        Text("登録済みの参照元から追加")
                            .padding(.vertical, 7.5)
                    }
                }
                
                HStack {
                    Image(systemName: "plus.app")
                        .listBlueIconExtension()
                    
                    NavigationLink(
                        destination: RegisterReferenceView()
                            .environmentObject(RegisterReferenceViewModel())
                    ) {
                        Text("新しく参照元を登録")
                            .padding(.vertical, 7.5)
                    }
                }
            }
            
            // 参照元の追加のスキップ時 → 確認画面に遷移
            NavigationLink(
                destination: ConfirmRegisterView()
            ) {
                Text("参照元の追加をスキップ")
                    .modifier(UnderContentDescription())
                    .padding(.bottom, 20)
            }
        }
    }
}
