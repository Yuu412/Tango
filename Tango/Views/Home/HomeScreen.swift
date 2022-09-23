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
                Spacer().frame(height: FrameSize().height * 0.05)
                HomeHeaderSection()
                HomeActivitySection()
                HomeContentsSection()
                Spacer()
            }
        }
    }
}

// ヘッダーセクション
struct HomeHeaderSection: View {
    var body: some View{
        HStack {
            VStack(alignment: .leading) {
                Text("SATURDAY, SEP 3")
                    .modifier(PageHeadline())
                Text("Summary")
                    .modifier(PageTitle())
            }
            .padding()
            Spacer()
        }
    }
}

// 活動記録セクション
struct HomeActivitySection: View {
    // 表示フラグ
    @State private var isReviewView: Bool = false
    
    var body: some View{
        VStack {
            // sectionタイトル
            HStack {
                Text("Activity")
                    .modifier(SectionTitle())
                Spacer()
            }
            .padding()
            
            // カード部分
            VStack {
                HStack {
                    Text("9月24日")
                        .modifier(PageHeadline())
                    Spacer()
                }
                .padding()
                
                // グラフ表示部分
                Image("activityGraphExample")
                    .resizable()
                    .scaledToFit()
                    .frame(width: FrameSize().width * 0.9)
                
                // 遷移ボタン部分
                HStack {
                    // 単語を追加するViewに遷移
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Image(systemName: "textformat")
                            Text("tangoを追加")
                                .modifier(ButtonTitle())
                        }
                    })
                    .modifier(HalfButton(color: BackgroundColor.lightBackground))
                    
                    
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
                    .modifier(HalfButton(color: BackgroundColor.blueBackground))
                    .sheet(isPresented: $isReviewView) {
                        ReviewScreen()
                            .environmentObject(ReviewViewModel())
                    }
                }
                .padding()
            }
            .modifier(CardView())
        }
    }
}

// 参考書一覧セクション
struct HomeContentsSection: View {
    var body: some View{
        VStack {
            // sectionタイトル
            HStack {
                Text("Contents")
                    .modifier(SectionTitle())
                Spacer()
            }
            .padding()
            
            // カード部分
            VStack {
                // 参考書表示部分
                
                HStack {
                    Spacer()
                    Image("TOEIC1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: FrameSize().width * 0.2)
                    Spacer()
                    Image("TOEIC2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: FrameSize().width * 0.2)
                    Spacer()
                    Image("TOEIC3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: FrameSize().width * 0.2)
                    Spacer()
                }
                .padding(.top, 20)
                
                HStack {
                    Spacer()
                    Image("emptyBook")
                        .resizable()
                        .scaledToFit()
                        .frame(width: FrameSize().width * 0.2)
                    Spacer()
                    Image("emptyBook")
                        .resizable()
                        .scaledToFit()
                        .frame(width: FrameSize().width * 0.2)
                    Spacer()
                    Image("emptyBook")
                        .resizable()
                        .scaledToFit()
                        .frame(width: FrameSize().width * 0.2)
                    Spacer()
                }
                .padding(.vertical, 20)
            }
            .modifier(CardView())
        }
    }
}
