//
//  EditCounterView.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/02.
//

import SwiftData
import SwiftUI

struct EditCounterView: View {
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \CounterGroup.name) private var groups: [CounterGroup]
    
    @Bindable var counter: Counter
    
    var counterService: CounterService
    
    let group: CounterGroup
    
    @State private var showConfirmation: Bool = false
    
    @FocusState var isFocused: Field?
    @State var newGroup: CounterGroup?
    
    var body: some View {
        Form{
            Section("General info"){
                TextField("", text: $counter.name, prompt:
                            Text("Title field can't be empty")
                            .foregroundStyle(.red))
                .focused($isFocused, equals: .name)
                .onSubmit { isFocused = .description }
                TextField("", text: $counter.subtitle)
                    .focused($isFocused, equals: .description)
                    .onSubmit{ isFocused = .counter}
                Picker("Group", selection: $newGroup){
                    ForEach(groups){ group in
                        Text(group.name).tag(group)
                    }
                }.onChange(of: newGroup){
                    if newGroup != nil && group != newGroup{
                        group.counters = group.counters.filter{ $0 != counter}
                        newGroup?.counters.append(counter)
                        dismiss()
                    }
                }
            }
            
            Section("Counter"){
                CounterStepperField(counter: counter, focusState: _isFocused, title: "count")
            }
            Button("Delete Counter", role: .destructive){
                showConfirmation = true
            }.confirmationDialog("Confirm", isPresented: $showConfirmation){
                Button("Cancel"){ showConfirmation = false}
                Button("Delete", role: .destructive) {
                    counterService.deleteCounter(counter, from: group)
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden(counter.name.isEmpty ? true : false)
        .navigationTitle("Edit Counter")
        .onAppear(){
            newGroup = group
        }
    }
}

#Preview {
    @Previewable @Environment(\.modelContext) var modelContext
    let counterService = CounterService(modelContext: modelContext)
    EditCounterView(counter: Counter(name: "Ejemplo para editar"),
                    counterService: counterService, group: CounterGroup(name: "Grupo"))
}
