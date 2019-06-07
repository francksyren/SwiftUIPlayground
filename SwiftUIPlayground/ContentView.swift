//
//  ContentView.swift
//  SwiftUIPlayground
//
//  Created by Syren, Franck on 6/6/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import SwiftUI
import Combine


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


extension Character : Identifiable {
    public var id: Int {
        return self.hashValue
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
                    NavigationButton(destination: DetailView(model: model).environmentObject(self.data)) {
                        if Int.random(in: 0..<10) % 2 == 0 {
                            Text("** \(model.name) **")
                        }
                        else {
                            VStack {
                                ForEach(Array(model.name)) { c in
                                    Text(String(c))
                                }
                            }
                        }
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
