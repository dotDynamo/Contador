//
//  CounterService.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/02.
//

import Foundation
import SwiftData

@MainActor
struct CounterService {
    let modelContext: ModelContext
    
    func addSamples(sampleSize: Int = 5) -> Void{
        let counter = Counter(name: "Contador \(1)", emoji: "🫠")
        modelContext.insert(counter)
    }
    
    func addCounter(counter: Counter) -> Void{
        modelContext.insert(counter)
    }
}
