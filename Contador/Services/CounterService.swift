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
    
    func addCounter(_ counter: Counter, group: CounterGroup) -> Void{
        group.counters.append(counter)
        modelContext.insert(group)
    }
    
    func deleteCounter(_ counter: Counter, from group: CounterGroup) -> Void{
        group.counters.removeAll{ $0 == counter}
        modelContext.delete(counter)
    }
    
    func addGroup(_ group: CounterGroup) -> Void{
        modelContext.insert(group)
    }
    func deleteGroup(_ group: CounterGroup) -> Void{
        let noGroup = try? modelContext.fetch(FetchDescriptor<CounterGroup>(predicate: #Predicate{$0.name == "No group"}))[0]
        for counter in group.counters {
            noGroup?.counters.append(counter)
        }
        group.counters.removeAll()
        modelContext.delete(group)
    }
    
    func checkName(_ name: String) -> Bool{
        let request = FetchDescriptor<CounterGroup>(
            predicate: #Predicate { $0.name == name }
        )
        if let groups = try? modelContext.fetch(request), groups.isEmpty {
            return true
        }
        return false
    }
    
    func getDefaultGroup() -> CounterGroup {
        let noGroup = try? modelContext.fetch(FetchDescriptor<CounterGroup>(predicate: #Predicate{$0.name == "No group"}))[0]
        return noGroup!
    }
}
