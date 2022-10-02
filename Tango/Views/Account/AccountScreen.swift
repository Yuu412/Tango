//
//  AccountScreen.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/19.
//

import SwiftUI
import Firebase

struct AccountScreen: View{
    // ログイン判定
    @AppStorage("log_status") var log_Status = false
    
    // sheetを閉じる環境変数
    @Environment(\.dismiss) var dismiss
    
    // お問い合わせ先の表示用変数
    @State private var isShowContact = false
    
    var body: some View{
        NavigationView {
            VStack{
                List {
                    // レビュー
                    Section {
                        Text("レビュー")
                    }
                    
                    // 情報
                    Section {
                        if let privacyPolicyUrl = URL(string: "https://yuu412.github.io/Tango_privacy_policy/") {
                            Link("プライバシーポリシー", destination: privacyPolicyUrl)
                        }
                        if let termOfServiceUrl = URL(string: "https://yuu412.github.io/Tango_terms_of_service/") {
                            Link("利用規約", destination: termOfServiceUrl)
                        }
                        Text("Tangoサポートへのお問い合わせ")
                            .onTapGesture {
                                self.isShowContact = true
                            }
                            .alert(isPresented: $isShowContact) {
                                Alert(title: Text("下記メールアドレスまでご連絡ください。"),
                                      message: Text("tango.english.app@gmail.com"),
                                      dismissButton: .default(Text("閉じる")))
                            }
                    }
                    
                    // 認証
                    Section {
                        Text("ログアウト")
                            .onTapGesture {
                                DispatchQueue.global(qos: .background).async {
                                    try? Auth.auth().signOut()
                                }
                                
                                withAnimation(.easeInOut) {
                                    self.log_Status = false
                                }
                            }
                    }
                }
                .navigationBarTitle("アカウント")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    trailing: Button(action: {
                        // sheetを閉じる
                        dismiss()
                    }, label: {
                        Text("閉じる")
                    })
                )
            }
        }
    }
}

