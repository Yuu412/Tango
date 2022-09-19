//
//  ReviewScreen.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/19.
//

import SwiftUI

struct ReviewScreen: View{
    
    @ObservedObject var tangoVM = ReviewViewModel()
    
    var progressValue: Float = 0.2
    
    
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
                
                // 学習した単語数を示すゲージ
                VStack {
                    ProgressView(value: progressValue)
                }
                .frame(width: FrameSize().width * 0.8)
                
                SwipeTangoView()
                
                Text("Hello")
                Spacer()
            }
            VStack(spacing: 15){
            }
        }
    }
}
