//
//  Model.swift
//  SwiftUIPlayground
//
//  Created by Syren, Franck on 6/7/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class SomeBindableObject : BindableObject {
    
    var someData = [SomeModel(name: "Franck"), SomeModel(name: "Sri"), SomeModel(name: "Jean-Yves")] {
        didSet {
            didChange.send(self)
        }
    }
    
    let didChange = PassthroughSubject<SomeBindableObject, Never>()
}

struct SomeModel : Identifiable {
    var id: String = UUID().uuidString
    
    var name: String
}
