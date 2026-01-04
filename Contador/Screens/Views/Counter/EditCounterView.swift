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
    
    @State private var showConfirmation: Bool = false
    
    var body: some View {
        Form{
            Section("General info"){
                TextField("", text: $counter.name, prompt:
                            Text("Title field can't be empty")
                            .foregroundStyle(.red))
                
                TextField("", text: $counter.subtitle)
            }
            
            Section("Counter"){
                CounterStepperField(counter: counter, title: "count")
            }
            Button("Delete Counter", role: .destructive){
                showConfirmation = true
            }.confirmationDialog("Confirm", isPresented: $showConfirmation){
                Button("Cancel"){ showConfirmation = false}
                Button("Delete", role: .destructive) {
                    counterService.deleteCounter(counter)
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden(counter.name.isEmpty ? true : false)
        .navigationTitle("Edit Counter")
    }
}

#Preview {
    @Previewable @Environment(\.modelContext) var modelContext
    let counterService = CounterService(modelContext: modelContext)
    EditCounterView(counter: Counter(name: "Ejemplo para editar"),
                    counterService: counterService)
}
