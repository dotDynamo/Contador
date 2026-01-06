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
    @FocusState var isFocused: Field?
    var hasName: Bool {
        counter.name.isEmpty
    }
    var isCounterFocused: Bool {
        isFocused == .counter
    }
    
    let group: CounterGroup
    
    var body: some View {
        Form{
            TextField("", text: $counter.name, prompt: Text("Counter name"))
                .focused($isFocused, equals: .name)
                .onSubmit { isFocused = .description}
            TextField("", text: $counter.subtitle, prompt: Text("Counter description"))
                .focused($isFocused, equals: .description)
                .onSubmit { isFocused = .counter}
            CounterStepperField(counter: counter, focusState: _isFocused, title: "Initial count")
            Button("Add new counter"){
                counterService.addCounter(counter, group: group)
                showSheet = false
            }.disabled(hasName)
        }
        .navigationTitle("New counter")
        .navigationBarTitleDisplayMode(.automatic)
        .onAppear(){
            isFocused = .name
        }
    }
}

#Preview {
    @Previewable @Environment(\.modelContext) var modelContext
    @Previewable @State var showSheet: Bool = true
    NewCounterView(
        counterService: CounterService(modelContext: modelContext), showSheet: $showSheet,
        counter: Counter(name: ""), group: CounterGroup(name: "Grupo 1"))
}
