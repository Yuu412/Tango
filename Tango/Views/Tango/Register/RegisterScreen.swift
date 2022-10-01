//
//  RegisterScreen.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/19.
//

import SwiftUI

struct RegisterScreen: View{
    var body: some View{
        ScrollView {
            VStack {
                Spacer().frame(height: FrameSize().height * 0.05)
                RegisterHeaderSection()
                
                Spacer()
            }
        }
    }
}

// ヘッダーセクション
struct RegisterHeaderSection: View {
    // 表示フラグ
    @State private var isRegisterView: Bool = false
    
    var body: some View{
        HStack {
            VStack(alignment: .leading) {
                HStack{
                    Text("登録済み単語")
                        .modifier(PageTitle())
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .foregroundColor(BackgroundColor.blueBackground)
                    })
                    .sheet(isPresented: $isRegisterView) {
                        RegisterView()
                            .environmentObject(ReviewViewModel())
                    }
                }
                
            }
            .padding()
            Spacer()
        }
    }
}


struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}
