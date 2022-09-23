//
//  ContentView.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/17.
//

import SwiftUI

struct ContentView: View {
    // ログイン判定
    @AppStorage("log_status") var log_Status = false
    
    var body: some View {
        ZStack {
            if self.log_Status {
                TabView {
                    HomeScreen()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    AccountScreen()
                        .tabItem {
                            Label("Account", systemImage: "person.crop.circle.fill")
                        }
                    RegisterScreen()
                        .tabItem {
                            Label("tango", systemImage: "textformat")
                        }
                }
            } else {
                // サインイン用ページ
                SignInScreen()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .background(BackgroundColor.background)
    }
}
