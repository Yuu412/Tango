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
    @ObservedObject var tangoScreenVM = TangoScreenViewModel()
    
    @State private var isReviewView: Bool = false
    @State var isPresentingModal: Bool = false
    //@State private var isExpand = false
    
    var body: some View{
        VStack(alignment: .leading) {
            ForEach(tangoScreenVM.references) { reference in
                // 参照元ごとのカード
                VStack {
                    HStack {
                        // カード左半分（カバー画像部分）
                        Image(uiImage: reference.image)
                            .registeredCoverImageExtension()
                        
                        Spacer()
                        
                        // カード右半分（タイトル・遷移ボタン部分）
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
                    
                    // 開閉式の単語一覧部分
                    DisclosureGroup(
                        content: {
                            Divider().frame(width: FrameSize().width * 0.8)
                            
                            ForEach(0 ..< reference.tangos.count, id: \.self) { index in
                                HStack {
                                    VStack {
                                        Text("\(index + 1)")
                                            .foregroundColor(TextColor.light)
                                            .frame(width: FrameSize().width * 0.1)
                                        Divider()
                                            .foregroundColor(BackgroundColor.darkBackground)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text("\(reference.tangos[index].enName) ( \(reference.tangos[index].jaName) )")
                                            .font(.system(Font.TextStyle.callout))
                                        Divider()
                                    }
                                    .frame(width: FrameSize().width * 0.7)
                                }
                            }
                        },
                        label: {
                            Text("単語一覧を表示")
                                .foregroundColor(TextColor.blue)
                                .font(.system(Font.TextStyle.footnote, weight: .bold))
                                .padding(.vertical, 5)
                        }
                    )
                    .frame(width: FrameSize().width * 0.3)
                    .padding(.vertical, 5)
                }
                .padding(EdgeInsets(
                    top: 15,
                    leading: 20,
                    bottom: 5,
                    trailing: 15
                ))
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


