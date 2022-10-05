//
//  ReviewScreen.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/19.
//
// Parent: HomeScreen

import SwiftUI

struct ReviewScreen: View{
    // 画面を閉じるための環境変数
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var tangoVM: ReviewViewModel
    
    var body: some View{
        
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 15){
                // 画面を閉じるための目印
                VStack{
                    Rectangle()
                        .background(Color.gray)
                        .frame(width: FrameSize().width * 0.1, height: 5)
                        .cornerRadius(99)
                        .foregroundColor(BackgroundColor.lightBackground)
                }
                .padding(.vertical, 20)
                
                if(self.tangoVM.isFinish){
                    // 復習終了時の画面
                    VStack{
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: FrameSize().width * 0.3)
                            .foregroundColor(BackgroundColor.blueBackground)
                            .padding(.vertical, 100)
                        
                        Text("お疲れ様でした！")
                            .modifier(SectionTitle())
                        
                        Spacer()
                        
                        // sheetを閉じるボタン
                        Button {
                            dismiss()
                        } label: {
                            Text("閉じる")
                                .modifier(DefaultButton(color: Color.blue))
                        }

                    }
                } else {
                    // 学習した単語数を示すゲージ
                    VStack {
                        ProgressView(value: tangoVM.gazeProgress)
                    }
                    .frame(width: FrameSize().width * 0.8)
                    
                    // 単語の表示
                    SwipeTangoView()
                    
                    // 単語の正解不正解ボタン表示
                }
                
                Spacer()
            }
            VStack(spacing: 15){
            }
        }
    }
}
