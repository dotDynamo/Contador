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
    
    func addCounter(_ counter: Counter) -> Void{
        modelContext.insert(counter)
    }
    
    func deleteCounter(_ counter: Counter) -> Void{
        modelContext.delete(counter)
    }
}
