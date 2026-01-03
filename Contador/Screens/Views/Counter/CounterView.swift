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
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
            HStack{
                Text(counter.emoji)
                    .font(.system(size: 50))
                Text(counter.name)
                    .padding(.leading, 15)
                Spacer()
                Text(String(counter.count))
                    .font(.system(size: 30))
            }
            .padding()
        }
    }
}

#Preview {
    CounterView(counter: Counter(name: "Carita",
                                 subtitle: "Este es un contador de ejemplo",
                                 emoji: "🫠",
                                 count: 0))
}
