//
//  ContentView.swift
//  SwiftUIPlayground
//
//  Created by Syren, Franck on 6/6/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import SwiftUI
import Combine


/*
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
*/

extension Character : Identifiable {
    public var id: Int {
        return self.hashValue
    }
}


struct InputBarView: View {
    
    @State private var value: String = ""
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            TextField($value, placeholder: Text("Ask CoPilot"), onCommit: {
                print("commit")
                
            })
            .textFieldStyle(.roundedBorder)
            .lineLimit(6)
            .flipsForRightToLeftLayoutDirection(true)
            .truncationMode(Text.TruncationMode.head)
            .allowsTightening(false)
            
            Button(action: {
                print("send")
            }) {
                Text("Send")
            }
        }
        .padding()
        .background(Color.red)
    }
}
/*

struct IfLet<T, Out: View>: View {
    let value: T?
    let produce: (T) -> Out
    
    init(_ value: T?, produce: @escaping (T) -> Out) {
        self.value = value
        self.produce = produce
    }
    
    var body: some View {
        Group {
            if value != nil {
                produce(value!)
            }
        }
    }
}
 */


struct MessageCellView : View {
    
    var model: Person
    
    var body: some View {
        
        Group {
            if model.isText {
                Spacer()
                Text("** \(model.name) **").background(Color.blue)
            }
            else {
                ViewBuilder.buildBlock(Image("person-placeholder").resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50, alignment: Alignment.center), Text("** \(model.name) **"))
            }
            
        }
    }
}


struct ContentView : View {
    
    @EnvironmentObject private var appData: ApplicationData
    
    @State private var isSomething = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle(isOn: $isSomething) {
                    Text("Enabled")
                }
                List(appData.model) { model in
                    
                    NavigationButton(destination: DetailView(model: model).environmentObject(self.data)) {
                        MessageCellView(model: model)
                    }
                }
                InputBarView()
            }
            .navigationBarTitle(Text("Welcome"))
            .navigationBarItems(trailing:
                Button(action: {
                    self.appData.model.append(Person(name: "Name...", type: .text) )
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
