//
//  ContentView.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/01.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var counterService: CounterService {
        CounterService(modelContext: modelContext)
    }
    
    var body: some View {
        GroupListingScreen(counterService: counterService)
            .task {
                checkGroups()
            }
    }
    
    @MainActor
    func checkGroups(){
        if let existingGroups: [CounterGroup] = try? modelContext.fetch(FetchDescriptor<CounterGroup>(sortBy: [])), existingGroups.isEmpty {
            let defaultGroup = CounterGroup(name: "No group", isDefault: true)
            modelContext.insert(defaultGroup)
        }
    }
}

#Preview {
    ContentView()
}
