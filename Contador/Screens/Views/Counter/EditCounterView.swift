//
//  EditCounterView.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/02.
//

import SwiftUI

struct EditCounterView: View {
    @Bindable var counter: Counter
    
    var body: some View {
        Form{
            Section("General info"){
                TextField("", text: $counter.name)
                TextField("", text: $counter.subtitle)
            }
            
            Section("Counter"){
                TextField("", text: Binding(
                    get: {String(counter.count)},
                    set: {newValue in
                        if let value = Int(newValue) {
                            counter.count = value <= 0 ? 0 : value
                        }
                    }
                ))
                    .keyboardType(.numberPad)
            }
        }
        .navigationTitle("Edit Counter")
    }
}

#Preview {
    EditCounterView(counter: Counter(name: "Ejemplo para editar"))
}
