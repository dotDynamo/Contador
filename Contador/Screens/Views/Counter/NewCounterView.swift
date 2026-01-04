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
    
    var hasName: Bool {
        counter.name.isEmpty
    }
    
    var body: some View {
        Form{
            TextField("", text: $counter.name, prompt: Text("Counter name"))
            TextField("", text: $counter.subtitle, prompt: Text("Counter description"))
            CounterStepperField(counter: counter, title: "Initial count")
            Button("Add new counter"){
                counterService.addCounter(counter)
                showSheet = false
            }.disabled(hasName)
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
