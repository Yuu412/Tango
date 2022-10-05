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
                RegisterHeaderSection()
                
                // 過去に登録した単語一覧
                ListTangoSection()
                Spacer()
            }
        }
        .padding(.top, 10)
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
            
        }
        .padding()
        Spacer()
        
    }
}

// ヘッダーセクション
struct ListTangoSection: View {
    @ObservedObject var referenceVM = ReferenceViewModel()
    
    // 表示フラグ
    @State private var isReviewView: Bool = false
    @State var isPresentingModal: Bool = false
    
    var body: some View{
        VStack(alignment: .leading) {
            ForEach(referenceVM.references) { reference in
                // 参照元ごとのカード
                VStack (spacing: 5){
                    HStack {
                        // カバー画像の場合
                        Image(uiImage: reference.image)
                            .registeredCoverImageExtension()
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            // 参考書のタイトル
                            Text(reference.title)
                                .lineLimit(3)
                            
                            Spacer()
                            
                            // 各種ボタン表示部分
                            ListTangoSectionButtonPart()
                            
                        }
                        .frame(width: FrameSize().width * 0.6)
                    }
                    
                    HStack {
                        Image(systemName: "chevron.down")
                        Text("単語一覧を表示")
                            .foregroundColor(TextColor.blue)
                            .font(.system(Font.TextStyle.callout, weight: .bold))
                    }
                    .foregroundColor(TextColor.blue)
                    .padding(.top, 10)
                    
                }
                .padding()
                .modifier(CardView())
            }
        }
    }
}

// 各種ボタン表示部分
struct ListTangoSectionButtonPart: View {
    // 表示フラグ
    @State private var isReviewView: Bool = false
    @State var isPresentingModal: Bool = false
    
    var body: some View {
        // 遷移ボタン部分
        HStack {
            // 単語を追加するViewに遷移
            Button(action: {
                isPresentingModal.toggle()
            }, label: {
                HStack {
                    Image(systemName: "textformat")
                    Text("追加")
                        .modifier(ButtonTitle())
                }
            })
            .modifier(RightHalfButton(color: BackgroundColor.lightBackground))
            .sheet(isPresented: $isPresentingModal) {
                RegisterTangoView()
                    .environmentObject(RegisterViewModel())
                    .environment(\.isPresentingModal, $isPresentingModal)
            }
            
            Spacer()
            
            // 復習を開始するViewに遷移
            Button(action: {
                isReviewView.toggle()
            }, label: {
                HStack {
                    Image(systemName: "play.fill")
                    Text("復習")
                        .modifier(ButtonTitle())
                }
            })
            .modifier(RightHalfButton(color: BackgroundColor.blueBackground))
            .sheet(isPresented: $isReviewView) {
                ReviewScreen()
                    .environmentObject(ReviewViewModel())
            }
        }
    }
}


