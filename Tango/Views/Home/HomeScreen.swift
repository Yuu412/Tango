//
//  HomeScreen.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/19.
//
// Parent: ContentView

import SwiftUI

struct HomeScreen: View{
    var body: some View{
        ScrollView {
            VStack {
                HomeHeaderSection()
                HomeActivitySection()
                HomeContentsSection()
                Spacer()
            }
        }
        .padding(.top, 10)
    }
}

// ヘッダーセクション
struct HomeHeaderSection: View {
    @State var isPresentingModal: Bool = false
    
    var body: some View{
        HStack {
            VStack(alignment: .leading) {
                Text("SATURDAY, SEP 3")
                    .modifier(PageHeadline())
                Text("Summary")
                    .modifier(PageTitle())
            }
            
            Spacer()
            
            // アカウント遷移部
            Button(action: {
                isPresentingModal.toggle()
                
            }, label: {
                Image(systemName: "person.crop.circle")
                    .topRightIconExtension()
            })
            .sheet(isPresented: $isPresentingModal) {
                AccountScreen()
                    .environmentObject(RegisterViewModel())
            }
        }
        .padding()
        
    }
}
