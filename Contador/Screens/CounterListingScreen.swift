//
//  CounterListingScreen.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/01.
//
import SwiftData
import SwiftUI

struct CounterListingScreen: View {
    //@Query(sort: \Counter.name) private var counters: [Counter]
    
    @State var showNewCounterSheet: Bool = false
    
    let group: CounterGroup
    var counters: [Counter]
    let counterService: CounterService
    
    var body: some View {
        VStack{
            if !counters.isEmpty{
                List{
                    ForEach(counters) { counter in
                        NavigationLink(value: counter){
                            CounterView(
                                counter: counter)
                        }
                    }
                    .onDelete{ indexSet in
                        for index in indexSet{
                            counterService.deleteCounter(counters[index], from: group)
                        }
                    }
                }.navigationDestination(for: Counter.self){counter in
                    EditCounterView(counter: counter, counterService: counterService, group: group)
                }
            }else {
                Text("No counters yet.\nUse the New Counter button to add one.")
            }
            
        }
        .navigationTitle("Contador")
        .toolbar{
            Button("New Counter"){ showNewCounterSheet = true }
        }
        .sheet(isPresented: $showNewCounterSheet){
            NavigationStack{
                let newCounter = Counter()
                NewCounterView(counterService: counterService, showSheet: $showNewCounterSheet, counter: newCounter, group: group)
            }
        }
    }
}
