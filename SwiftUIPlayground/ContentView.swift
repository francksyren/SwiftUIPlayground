//
//  ContentView.swift
//  SwiftUIPlayground
//
//  Created by Syren, Franck on 6/6/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import SwiftUI
import Combine

final class SomeBindableObject : BindableObject {
    
    var someData = [SomeModel(name: "Franck"), SomeModel(name: "Sri"), SomeModel(name: "Stefan")] {
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

struct DetailView: View {
    @EnvironmentObject private var data: SomeBindableObject
    
    var model: SomeModel
    
    var modelIndex: Int {
        data.someData.firstIndex(where: {
            print("\($0.id) ... \(model.id)")
            return $0.id == model.id
        })!
    }
    
    
    
    var body: some View {
        Text("Detail for name \(data.someData[self.modelIndex].name)")
            .font(.largeTitle)
            .navigationBarItems(trailing:
                Button(action: {
                    self.data.someData[self.modelIndex].name = "2.0"
                }) {
                    Text("Change name")
            })
    }
}

struct SomeButton : View {
    
    @Binding var isFun: Bool
    
    var body: some View {
        Button(action: {
            print("playing")
        }) {
            Text("Play Me!")
        }
    }
}

struct ContentView : View {
    
    @EnvironmentObject private var data: SomeBindableObject
    
    @State private var isFun = false
    
    var body: some View {
        NavigationView {
            VStack {
                SomeButton(isFun: $isFun)
                List(data.someData) { model in
                    NavigationButton(destination: DetailView(model: model).environmentObject(self.data) ) {
                        Text("Your name is \(model.name)")
                    }
                }
            }.navigationBarTitle(Text("Welcome"))
            .navigationBarItems(trailing:
                Button(action: {
                    self.data.someData.append(SomeModel(name: "Name...") )
                }) {
                    Text("Add")
            })
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
