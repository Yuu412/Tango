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
        VStack(alignment: .leading) {
            HStack{
                Text("登録済み単語")
                    .modifier(PageTitle())
                
                Spacer()
                
                Button(action: {
                    isPresentingModal.toggle()
                    
                }, label: {
                    Image(systemName: "plus.circle")
                        .topRightIconExtension()
                })
                .sheet(isPresented: $isPresentingModal) {
                    RegisterTangoView()
                        .environmentObject(RegisterViewModel())
                        .environment(\.isPresentingModal, $isPresentingModal)
                }
            }
            
            // 過去に登録した単語一覧
            ListTangoSection()
            
        }
        .padding()
        Spacer()
        
    }
}

// ヘッダーセクション
struct ListTangoSection: View {
    @ObservedObject var referenceVM = ReferenceViewModel()
    
    var body: some View{
        VStack(alignment: .leading) {
            ForEach(referenceVM.references) { reference in
                // 参照元ごとのカード
                VStack (spacing: 5){
                    HStack {
                        // カバー画像の場合
                        Image(uiImage: reference.image)
                            .registeredCoverImageExtension()
                        
                        VStack (){
                            // 参考書のタイトル
                            Text(reference.title)
                            
                            Spacer()
                            
                            // ボタン
                            HStack {
                                Text("追加")
                                    .modifier(RightHalfButton(color: BackgroundColor.lightBackground))
                                Text("復習")
                                    .modifier(RightHalfButton(color: BackgroundColor.blueBackground))
                            }
                        }
                        .frame(width: FrameSize().width * 0.6)
                    }
                    
                    HStack {
                        Image("")
                        
                        Text("単語一覧を表示")
                    }
                    
                }
                .modifier(CardView())
            }
        }
    }
}

struct TangoScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        TangoScreen()
            .background(BackgroundColor.background)
    }
}

