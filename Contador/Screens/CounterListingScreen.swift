//
//  CounterListingScreen.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/01.
//
import SwiftData
import SwiftUI

struct CounterListingScreen: View {
    @State var showNewCounterSheet: Bool = false
    @State var showConfirmation: Bool = false
    
    let group: CounterGroup
    var counters: [Counter]
    let counterService: CounterService
    
    var body: some View {
        VStack{
            if !counters.isEmpty{
                List{
                    ForEach(counters) { counter in
                        NavigationLink(destination: EditCounterView(counter: counter, counterService: counterService, group: group)){
                            CounterView(counter: counter)
                        }
                    }
                    .onDelete{ indexSet in
                        for index in indexSet{
                            counterService.deleteCounter(counters[index], from: group)
                        }
                    }
                }
            }else {
                Text("No counters yet.\nUse the New Counter button to add one.")
            }
            
        }
        .navigationTitle(group.name)
        .navigationSubtitle(group.isPrivate ? "Private" : "Public")
        .toolbar{
            Button("New Counter"){ showNewCounterSheet = true }
            Menu("..."){
                Button("Change visibility"){ group.isPrivate.toggle() }
            }
        }
        .sheet(isPresented: $showNewCounterSheet){
            NavigationStack{
                let newCounter = Counter()
                NewCounterView(counterService: counterService, showSheet: $showNewCounterSheet, counter: newCounter, group: group)
            }
        }
    }
}
