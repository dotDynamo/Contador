//
//  ContentView.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/01.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var counterService: CounterService {
        CounterService(modelContext: modelContext)
    }
    
    var body: some View {
        CounterListingScreen(counterService: counterService)
    }
}

#Preview {
    ContentView()
}
