//
//  ReviewView.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/18.
//

import SwiftUI

struct ReviewView2: View{
    var body: some View{
        
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 15){
                Spacer().frame(height: FrameSize().height * 0.1)
                
                Text("---------------------------")
            
                
                SwipeTangoView()
                
                Text("Hello")
                Spacer()
            }
            VStack(spacing: 15){
            }
        }
    }
}
