//
//  ReferenceViewModel.swift
//  Tango
//
//  Created by Yoshida Yuya on 2022/09/25.
//

import Foundation
import FirebaseFirestore
import Combine

class ReferenceViewModel: ObservableObject {

    @Published var referenceRepository = ReferenceRepository()
    @Published var references: [References.Reference] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        // repositoryでFirebaseから取得したリストを取得
        referenceRepository.$references.assign(to: \.references, on: self)
            .store(in: &cancellables)
    }

}
