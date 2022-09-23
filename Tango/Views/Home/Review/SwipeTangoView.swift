//
//  SwipeTangoView.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/19.
//
// Parent: ReviewSceen

import SwiftUI

struct SwipeTangoView: View {
    var betweenSpace: CGFloat = 20  // カード間のスペース
    var hidenCardWidth: CGFloat = 10    // 左右に隠れて見える部分のカードの幅
    var cardSize: CGFloat   //カードの幅(高さ)
    var ignoreSwipeRange: CGFloat = 150 // スライドによる切替りを無効化する移動量(x)
    
    @State private var offset = CGFloat.zero
    // 移動量(x)の合計
    @State private var stackWidth: CGFloat = CGFloat.zero
    
    @EnvironmentObject var tangoVM: ReviewViewModel
    
    init() {
        self.cardSize = FrameSize().width - (betweenSpace * 2) - (hidenCardWidth * 2)
    }
    
    var body: some View {
        HStack(spacing: betweenSpace) {
            ForEach(tangoVM.tangoList) { tango in
                VStack(spacing: 20) {
                    Text(tango.enName)
                        .font(.system(Font.TextStyle.title, weight: .bold))
                    
                    Text(tango.jaName)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                        .padding(.bottom, 20)
                    
                    Text(tango.enSentence)
                        .font(.system(Font.TextStyle.callout))
                    
                    Text(tango.jaSentence)
                        .font(.system(Font.TextStyle.caption))
                        .foregroundColor(TextColor.light)
                    
                    Spacer()
                }
                .frame(width: cardSize)
            }
        }
        .contentShape(Rectangle())  // Tapで反応するエリアを拡張
        .offset(x: (betweenSpace + cardSize) * CGFloat(tangoVM.tangoList.count - 1) / 2 + stackWidth + offset)  // 画面中心のx座標を計算
        .gesture( DragGesture()
            .onChanged { value in
                // gestureが変化したときの動作を定義
                if stackWidth == 0 {
                    // 配列先頭の要素の場合は、x<0の動きにのみ対応
                    if value.translation.width < 0{
                        self.offset = value.translation.width
                    }
                } else if stackWidth == -CGFloat(tangoVM.tangoList.count - 1) * (cardSize + betweenSpace) {
                    // 配列末尾の要素の場合
                    if value.translation.width > 0 {
                        self.offset = value.translation.width
                    }
                } else {
                    self.offset = value.translation.width
                }
            }
            .onEnded { value in
                // gestureが変化したときの動作を定義
                self.offset = .zero
                // x方向への座標の変化量
                let xWidth = value.translation.width
                
                if stackWidth == 0 {
                    // 配列先頭の要素の場合は、x<0の動きにのみ対応
                    if xWidth < -ignoreSwipeRange{
                        // Hstackの中心をx軸マイナス方向に移動 -> 中心となる配列の要素を次の要素とする
                        stackWidth -= cardSize + betweenSpace
                        tangoVM.addGazeProgress(listCount: tangoVM.tangoList.count)
                    }
                } else {
                    if xWidth < -ignoreSwipeRange {
                        stackWidth -= cardSize + betweenSpace
                        tangoVM.addGazeProgress(listCount: tangoVM.tangoList.count)
                    } else if xWidth > ignoreSwipeRange {
                        stackWidth += cardSize + betweenSpace
                        tangoVM.subGazeProgress(listCount: tangoVM.tangoList.count)
                    }
                }
            }
        )
    }
}
