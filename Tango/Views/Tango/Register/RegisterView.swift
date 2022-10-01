//
//  RegisterView.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/24.
//

import SwiftUI

struct RegisterView: View{
    var body: some View{
        NavigationView {
            NavigationLink(destination: PushView()) {
                Text("Show PushView.")
            }.navigationBarTitle("ContentView", displayMode: .inline)
        }
    }
}
