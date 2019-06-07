//
//  DetailView.swift
//  SwiftUIPlayground
//
//  Created by Syren, Franck on 6/7/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import SwiftUI

struct DetailView : View {
    @EnvironmentObject private var data: SomeBindableObject
    
    var model: SomeModel
    
    var modelIndex: Int {
        data.someData.firstIndex(where: {
            return $0.id == model.id
        })!
    }
    
    var body: some View {
        HStack(alignment: VerticalAlignment.firstTextBaseline) {
            Text("Name: \(data.someData[self.modelIndex].name)")
                .font(.largeTitle)
                .layoutPriority(1)
            Image("person-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50, alignment: Alignment.center)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .font(.caption)
            
            }.padding(10)
            .navigationBarItems(trailing:
                Button(action: {
                    self.data.someData[self.modelIndex].name = "2.0"
                }) {
                    Text("Change name")
            })
    }
    
}


#if DEBUG
struct DetailView_Previews : PreviewProvider {
    static var previews: some View {
        DetailView(model: SomeModel(name: "DetailView_Previews"))
    }
}
#endif