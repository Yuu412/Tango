//
//  TangoApp.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/17.
//

import SwiftUI
import FirebaseCore
import Firebase

@main
struct TangoApp: App {
    // Calling Delegate...
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
 
// FirebaseをAppの起動時に初期化するための処理
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
