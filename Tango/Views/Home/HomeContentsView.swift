//
//  HomeContentsView.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/10/02.
//
import SwiftUI

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
