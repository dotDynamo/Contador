//
//  NewCounterGroupView.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/05.
//

import SwiftData
import SwiftUI

struct NewCounterGroupView: View {
    var counterService: CounterService
    @Binding var showSheet: Bool
    @Bindable var counterGroup: CounterGroup
    @FocusState var isFocused: Field?
    var hasName: Bool{
        if !counterGroup.name.isEmpty && counterGroup.name.count < 30 { false }
        else { true }
    }

    var body: some View {
        Form{
            TextField("Nuevo nombre del grupo", text: $counterGroup.name)
            Button("Create group"){
                if counterService.checkName(counterGroup.name){
                    counterService.addGroup(counterGroup)
                    showSheet = false
                }else{
                    counterGroup.name = "Pene"
                }
            }
            .disabled(hasName)
        }
    }
}

#Preview {
    @Previewable @Environment(\.modelContext) var modelContext
    @Previewable @State var showSheet: Bool = true
    NewCounterGroupView(
        counterService: CounterService(modelContext: modelContext), showSheet: $showSheet,
        counterGroup: CounterGroup(name: ""))
}
