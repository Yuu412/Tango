//
//  SignInViewModel.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/23.
//

import SwiftUI
import CryptoKit
import AuthenticationServices
import Firebase

class SignInViewModel: ObservableObject {
    @Published var nonce = randomNonceString()
    @AppStorage("log_status") var log_Status = false
    
    func authenticate(credential: ASAuthorizationAppleIDCredential) {
        // getting Token...
        guard let token = credential.identityToken else {
            print("error with Firebase")
            return
        }
        
        // Token String...
        guard let tokenString = String(data: token, encoding: .utf8) else {
            print("error with Token")
            return
        }
        
        // Initialize a Firebase credential.
        let firebaseCredential = OAuthProvider.credential(
            withProviderID: "apple.com",
            idToken: tokenString,
            rawNonce: nonce
        )
        
        Auth.auth().signIn(with: firebaseCredential) { (result, err) in
            if let error = err {
                print(error.localizedDescription)
            }
        }
        
        // User Successfully logged into Firebase...
        print("Sign In Success")
        
        // Directing User To Home Page...
        withAnimation(.easeInOut) {
            self.log_Status = true
        }
        
    }
    
}

// helpers for Apple Sign in with Firebase
// https://firebase.google.com/docs/auth/ios/apple?authuser=0

// ----------------------------------------------------
// 1. ログインリクエストごとにランダムな文字列「ナンス」を生成します。
// ナンスは、取得したIDトークンが、当該アプリの認証リクエストへのレスポンスとして付与されたことを確認するために使用します。
// この手順は、リプレイ攻撃の防止に重要です。
// ----------------------------------------------------

func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}

func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }
      return random
    }

    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }

      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }

  return result
}


// ----------------------------------------------------
// 1. ログインリクエストごとにランダムな文字列「ナンス」を生成します。
// ナンスは、取得したIDトークンが、当該アプリの認証リクエストへのレスポンスとして付与されたことを確認するために使用します。
// この手順は、リプレイ攻撃の防止に重要です。
// ----------------------------------------------------
