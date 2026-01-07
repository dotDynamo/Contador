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
    
    @State var errorPrompt: String = "Title must be provided"
    
    var hasName: Bool{
        if !counterGroup.name.isEmpty && counterGroup.name.count < 30 { false }
        else { true }
    }

    var body: some View {
        Form{
            TextField("", text: $counterGroup.name,
                      prompt: Text(errorPrompt)
                .foregroundStyle(errorPrompt.isEmpty ? .gray : .red))
            Button("Create group"){
                if counterService.checkName(counterGroup.name){
                    counterService.addGroup(counterGroup)
                    showSheet = false
                    errorPrompt = ""
                }else{
                    counterGroup.name = ""
                    errorPrompt = "Title has to be unique"
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
