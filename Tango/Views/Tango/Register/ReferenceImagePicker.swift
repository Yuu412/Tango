//
//  ReferenceImagePicker.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/25.
//

import SwiftUI
import PhotosUI

struct ReferenceImagePicker: UIViewControllerRepresentable {
    // create binding used to return selected image
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        // PHPickerの設定を記載
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0
        
        // インスタンスを生成
        let picker = PHPickerViewController(configuration: config)
        
        // delegateを設定
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // create a coordinator to pull the sequence of event together
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ReferenceImagePicker
        
        init(_ parent: ReferenceImagePicker){
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]){
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else {return}
            
            if provider.canLoadObject(ofClass: UIImage.self){
                provider.loadObject(ofClass: UIImage.self){ image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}
