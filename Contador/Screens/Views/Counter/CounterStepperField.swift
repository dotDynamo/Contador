//
//  CounterStepperField.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/04.
//

import SwiftUI

struct CounterStepperField: View {
    @Bindable var counter: Counter
    var title: String
    var body: some View {
        HStack(spacing:20){
            Text(title)
            TextField("", text: Binding(
                get: {String(counter.count)},
                set: {newValue in
                    if let value = Int(newValue) {
                        counter.count = value <= 0 ? 0 : value
                    }
                }
            ))
                .keyboardType(.numberPad)
            Stepper("", value: $counter.count, in: 0...1000)
                .labelsHidden()
        }
    }
}

#Preview {
    CounterStepperField(counter: Counter(name: "Carita",
                                         subtitle: "Hola",
                                         emoji: "😃",
                                         count: 2),
                        title: "Counter stepper field")
}
