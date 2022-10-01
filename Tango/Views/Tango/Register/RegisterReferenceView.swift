//
//  RegisterReferenceView.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/24.
//
// Parent: SelectReferenceTypeView

import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseFirestore

struct RegisterReferenceView: View {
    
    @EnvironmentObject var registerReferenceVM: RegisterReferenceViewModel
    @EnvironmentObject var registerVM: RegisterViewModel
    
    // ReferenceImagePickerの発火フラグ
    @State var showReferenceImagePicker: Bool = false
    
    // 「<戻る」処理を行うための変数
    @Environment(\.presentationMode) var presentation
    
    var body: some View{
        VStack {
            // 「参照元を登録」
            Text("参照元を登録")
                .modifier(SectionTitle())
                .padding(.vertical, 15)
            
            // 「カバー画像の追加」トリガー：画像
            if registerReferenceVM.referenceImage != nil {
                // referenceImage をアンラップ
                registerReferenceVM.referenceImage?
                    .coverImageExtension()
                    .background(BackgroundColor.reverseBackground)
                    .border(BackgroundColor.lightBackground, width: 1)
                
                // 「カバー画像を変更」トリガー：ラベル
                Text("カバー画像を変更")
                    .modifier(UnderContentDescription())
            } else {
                // 「カバー画像の追加」トリガー：画像
                Image("referenceExample")
                    .coverImageExtension()
                // 「カバー画像の追加」トリガー：ラベル
                Text("カバー画像を追加")
                    .modifier(UnderContentDescription())
            }
        }
        .onTapGesture{
            showReferenceImagePicker = true
        }
        .onChange(of: registerReferenceVM.inputImage){ _ in registerReferenceVM.loadImage()}
        .sheet(isPresented: $showReferenceImagePicker){
            ReferenceImagePicker(image: $registerReferenceVM.inputImage)
        }
        
        
        // 参照元の情報の入力フォーム
        Form {
            HStack {
                Text("タイトル")
                    .frame(width: FrameSize().width * 0.2, alignment: .leading)
                TextField(text: $registerReferenceVM.title, prompt: Text("必須")) {}
                
            }
            HStack{
                Text("備考")
                    .frame(width: FrameSize().width * 0.2, alignment: .leading)
                TextField(text: $registerReferenceVM.label, prompt: Text("任意（例：TOEIC対策用）")) {}
            }
        }
        
        // 入力チェック
        if registerReferenceVM.title.isEmpty {
            // 「登録」ボタン：非活性
            Text("登録")
                .modifier(DefaultButton(color: Color.gray))
                .padding(.vertical, 20)
        } else {
            // 参照元を追加して一つ前のページに戻る
            Text("登録")
                .modifier(DefaultButton(color: Color.blue))
                .onTapGesture {
                    registerReferenceVM.addReference()
                    // 「戻る」処理
                    self.presentation.wrappedValue.dismiss()
                }
                .padding(.bottom, 20)
        }
    }
}
