//
//  SignInScreen.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/23.
//
import SwiftUI
import AuthenticationServices

struct SignInScreen: View{
    
    @StateObject var signInData = SignInViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "character.textbox")
                .resizable()
                .scaledToFit()
                .frame(width: FrameSize().width * 0.2)
                .foregroundColor(BackgroundColor.blueBackground)
                .padding(EdgeInsets(
                    top: FrameSize().height * 0.1,
                    leading: 0,
                    bottom: 25,
                    trailing: 0
                ))
            
            Text("Tango")
                .modifier(PageTitle())
                .padding(.vertical, 10)
                .frame(alignment: .center)
            
            Text("Tangoはあなただけのオリジナル単語帳を作成し、忘却曲線に沿った反復学習が行える英単語復習アプリです。")
                .modifier(PageHeadline())
                .frame(width: FrameSize().width * 0.8)
            
            
            Spacer()
            
            // Sign in with apple ボタン
            SignInWithAppleButton { (request) in
                // requesting paramertes from apple login...
                signInData.nonce = randomNonceString()
                request.requestedScopes = [.email, .fullName]
                request.nonce = sha256(signInData.nonce)
                
            } onCompletion: { (result) in
                // getting error or success...
                switch result {
                case .success(let user):
                    // do Sign in with Firebase...
                    print("success")
                    guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                        print("error with Firebase")
                        return
                    }
                    signInData.authenticate(credential: credential)
                    
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            .signInWithAppleButtonStyle(.white)
            .frame(width: FrameSize().width * 0.8, height: 55)
            .clipShape(Capsule())
            .padding(.bottom, 50)
        }
    }
    
}
