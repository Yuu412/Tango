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
    
    var body: some View{
        VStack{
            Button(action: {
                DispatchQueue.global(qos: .background).async {
                    try? Auth.auth().signOut()
                }
                
                withAnimation(.easeInOut) {
                    self.log_Status = false
                }
                
            }, label: {
                Text("log Out")
                    .modifier(PageTitle())
            })
            
        }
    }
}

