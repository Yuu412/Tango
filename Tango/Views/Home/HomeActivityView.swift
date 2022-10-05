//
//  HomeActivityView.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/10/02.
//

import SwiftUI
import Charts

// 活動記録セクション
struct HomeActivitySection: View {
    var body: some View{
        VStack {
            // セクションタイトル
            HomeActivitySectionTitlePart()
            
            // アクティビティのカード部分
            HomeActivityCardPart()
        }
    }
}

// セクションタイトル
struct HomeActivitySectionTitlePart: View {
    var body: some View {
        // グラフ表示部分
        // sectionタイトル
        
        HStack {
            Text("Activity")
                .modifier(SectionTitle())
            Spacer()
        }
        .padding()
    }
}

// アクティビティのカード部分
struct HomeActivityCardPart: View {
    @ObservedObject var activityVM = HomeActivityViewModel()
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("9月24日")
                    .modifier(PageHeadline())
                Spacer()
                VStack (alignment: .leading) {
                    Text("Total")
                        .font(.system(Font.TextStyle.footnote, weight: .bold))
                        .foregroundColor(TextColor.light)
                    HStack(alignment: .bottom) {
                        Text(String(activityVM.tangoAmountsSum))
                            .font(.system(Font.TextStyle.largeTitle, weight: .bold))
                        Text("tango")
                            .font(.system(Font.TextStyle.footnote, weight: .bold))
                            .foregroundColor(TextColor.light)
                    }
                }
                .padding(.horizontal, 10)
            }
            .padding()
            
            // グラフ表示部分
            HomeActivityGraphPart()
                .environmentObject(HomeActivityViewModel())
            
            // 各種ボタン表示部分
            HomeActivityButtonPart()
            
        }
        .modifier(CardView())
    }
}

// 活動記録グラフ部分
struct HomeActivityGraphPart: View {
    @EnvironmentObject var activityVM: HomeActivityViewModel
    
    var body: some View {
            // グラフ表示部分
            Chart(activityVM.tangoAmounts) { data in
                LineMark(
                    x: .value("Name", data.date),
                    y: .value("Amount", data.amount)
                )
                .foregroundStyle(BackgroundColor.blueBackground.gradient)
                .lineStyle(StrokeStyle(lineWidth: 2))
                .interpolationMethod(.catmullRom)
            }
            .frame(height: FrameSize().height * 0.15)
            .chartYScale(domain: .automatic(includesZero: false), range: .plotDimension(padding: 10))
            .padding(.horizontal, 20)
            .chartXAxis(Visibility.hidden)
            .chartYAxis(Visibility.hidden)
        
    }
}

// 各種ボタン表示部分
struct HomeActivityButtonPart: View {
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
                    Text("tangoを追加")
                        .modifier(ButtonTitle())
                }
            })
            .modifier(HalfButton(color: BackgroundColor.lightBackground))
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
            .modifier(HalfButton(color: BackgroundColor.blueBackground))
            .sheet(isPresented: $isReviewView) {
                ReviewScreen()
                    .environmentObject(ReviewViewModel())
            }
        }
        .padding()
    }
}

