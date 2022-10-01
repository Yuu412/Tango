//
//  TangoScreen.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/24.
//

import SwiftUI

struct TangoScreen: View{
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

// 閉じる・開くの制御なので Bool
struct PresentingModalKey: EnvironmentKey {
    static let defaultValue = Binding<Bool>.constant(false)
}
// 自作環境変数
extension EnvironmentValues {
    var isPresentingModal: Binding<Bool> {
        get { self[PresentingModalKey.self] }
        set { self[PresentingModalKey.self] = newValue }
    }
}


// ヘッダーセクション
struct RegisterHeaderSection: View {
    // 表示フラグ
    @State private var isRegisterView: Bool = false
    
    @State var isPresentingModal: Bool = false
    
    var body: some View{
        HStack {
            VStack(alignment: .leading) {
                HStack{
                    Text("登録済み単語")
                        .modifier(PageTitle())
                    Spacer()
                    Button(action: {
                        isPresentingModal.toggle()
                        
                    }, label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .foregroundColor(BackgroundColor.blueBackground)
                    })
                    .sheet(isPresented: $isPresentingModal) {
                        RegisterTangoView()
                            .environmentObject(RegisterViewModel())
                            .environment(\.isPresentingModal, $isPresentingModal)
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
        TangoScreen()
    }
}
