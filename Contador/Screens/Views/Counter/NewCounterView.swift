//
//  NewCounterView.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/02.
//

import SwiftUI

struct NewCounterView: View {
    var counterService: CounterService
    @Binding var showSheet: Bool
    @Bindable var counter: Counter
    
    var body: some View {
        Form{
            TextField("", text: $counter.name, prompt: Text("Counter name"))
            TextField("", text: $counter.subtitle, prompt: Text("Counter description"))
            HStack(spacing:20){
                Text("Initial count")
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
            Button("Add new counter"){
                counterService.addCounter(counter: counter)
                showSheet = false
            }
        }
        .navigationTitle("New counter")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

#Preview {
    @Previewable @Environment(\.modelContext) var modelContext
    @Previewable @State var showSheet: Bool = true
    NewCounterView(
        counterService: CounterService(modelContext: modelContext), showSheet: $showSheet,
        counter: Counter(name: ""))
}
