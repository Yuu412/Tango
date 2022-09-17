//
//  ContentView.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
            RegisterView()
                .tabItem {
                    Label("tango", systemImage: "textformat")
                }
            
        }
    }
}


struct SummaryView: View{
    var body: some View{
        VStack{
            
        }
        .frame(width: FrameSize().width, height: FrameSize().height * 0.775)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .background(BackgroundColor.background)
            .environment(\.colorScheme, .dark)
    }
}
