//
//  CounterView.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/01.
//

import SwiftData
import SwiftUI

struct CounterView: View {
    let counter: Counter
    
    var body: some View {
        HStack{
            Text(counter.emoji)
                .font(.system(size: 50))
            VStack(alignment: .leading){
                Text(counter.name)
                if !counter.subtitle.isEmpty{
                    Text(counter.subtitle)
                }
            }
            .padding(.leading, 15)
            Spacer()
            Text(String(counter.count))
                .font(.system(size: 30))
        }
        .padding()
    }
}

#Preview {
    CounterView(counter: Counter(name: "Carita",
                                 subtitle: "Hola",
                                 emoji: "😃",
                                 count: 2))
}
