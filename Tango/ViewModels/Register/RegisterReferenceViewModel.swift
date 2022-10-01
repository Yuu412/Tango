//
//  RegisterReferenceViewModel.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/24.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import PhotosUI

class RegisterReferenceViewModel: ObservableObject {
    @Published var referenceRepository = ReferenceRepository()
    @Published var referenceImage: Image? // デフォルト画像を設定

    @Published var title = "" // 参照元のタイトル
    @Published var label = "" // ラベル
    @Published var inputImage: UIImage? // アップロード画像
    
    // UIImageをImagenに変換
    func loadImage() {
        guard let inputImage = inputImage else {return}
        referenceImage = Image(uiImage: inputImage)
    }
    
    // Firebaseに参照元を追加
    func addReference() {
        referenceRepository.addData(
            title: self.title,
            label: self.label,
            image: self.inputImage
        )
    }
}
