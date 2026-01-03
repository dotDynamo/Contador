//
//  EditCounterView.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/02.
//

import SwiftUI

struct EditCounterView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var counter: Counter
    
    var counterService: CounterService
    
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
            Button("Delete Counter"){
                counterService.deleteCounter(counter)
                dismiss()
            }
        }
        .navigationTitle("Edit Counter")
    }
}

#Preview {
    @Previewable @Environment(\.modelContext) var modelContext
    var counterService = CounterService(modelContext: modelContext)
    EditCounterView(counter: Counter(name: "Ejemplo para editar"),
                    counterService: counterService)
}
