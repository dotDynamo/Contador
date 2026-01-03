//
//  CounterListingScreen.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/01.
//
import SwiftData
import SwiftUI

struct CounterListingScreen: View {
    @Query(sort: \Counter.name) private var counters: [Counter]
    
    @State var showNewCounterSheet: Bool = false
    
    let counterService: CounterService
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(counters) { counter in
                    CounterView(
                        counter: counter
                    )
                }
            }
            .navigationTitle("Contador")
            .toolbar{
                Button("New Counter"){
                    showNewCounterSheet = true
                }
            }
            .sheet(isPresented: $showNewCounterSheet){
                NavigationStack{
                    let newCounter = Counter()
                    NewCounterView(counterService: counterService, showSheet: $showNewCounterSheet, counter: newCounter)
                }
            }
            
        }
    }
}
