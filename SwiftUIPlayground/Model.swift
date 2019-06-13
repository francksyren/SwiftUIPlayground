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

final class ApplicationData : BindableObject {
    
    var model = [Person(name: "Franck", type: .text),
                    Person(name: "Sri", type: .text),
                    Person(name: "Jean-Yves", type: .text),
                    Person(name: "Stefan", type: .image("https://pbs.twimg.com/profile_images/497297322867306496/Pz938i1Q_400x400.jpeg")),
                    Person(name: "Sean", type: .text),
                    Person(name: "Ravikumar J.", type: .text)] {
        didSet {
            didChange.send(self)
        }
    }
    
    let didChange = PassthroughSubject<ApplicationData, Never>()
}

struct Person : Identifiable {
    var id: String = UUID().uuidString
    
    var name: String
    
    var type: RowType
    
    var isText : Bool {
        return type == RowType.text
    }
}

enum RowType : Equatable {
    case text
    case image(String)
}
