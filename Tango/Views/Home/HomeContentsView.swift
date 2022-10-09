//
//  HomeContentsView.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/10/02.
//
import SwiftUI

// 参考書一覧セクション
struct HomeContentsSection: View {
    @ObservedObject var referenceVM = ReferenceViewModel()
    
    // コンテンツ表示のレイアウト指定（3列ずつの配列）
    private var gridItemLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
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
                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                    ForEach(referenceVM.references) { reference in
                        Image(uiImage: reference.image)
                            .registeredCoverImageExtension()
                    }
                }
                .padding(.vertical, 20)
            }
            .modifier(CardView())
        }
    }
}
