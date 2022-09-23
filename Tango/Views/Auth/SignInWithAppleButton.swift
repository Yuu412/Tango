//
//  SignInWithAppleButton.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/23.
//

import Foundation
import SwiftUI
import AuthenticationAServices

struct SignInWithAppleButton: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .white)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}
