//
//  GroupListingScreen.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/05.
//

import SwiftData
import SwiftUI

struct GroupListingScreen: View {
    @Query(sort: \CounterGroup.name) private var groups: [CounterGroup]
    @Environment(\.modelContext) private var modelContext
    
    @State var showNewCounterSheet: Bool = false
    
    let counterService: CounterService
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(groups){ group in 
                        NavigationLink(value: group){
                            Text(group.name)
                        }
                        .swipeActions(edge: .trailing) {
                            if !group.isDefault {
                                Button(role: .destructive) {
                                    counterService.deleteGroup(group)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }.navigationDestination(for: CounterGroup.self){ group in
                    CounterListingScreen(group: group, counters: group.counters, counterService: counterService)
                }
            }.toolbar{
                Button("New Group"){ showNewCounterSheet = true }
            }
            .sheet(isPresented: $showNewCounterSheet){
                NavigationStack{
                    NewCounterGroupView(counterService: counterService, showSheet: $showNewCounterSheet, counterGroup: CounterGroup())
                }
            }
        }
    }
    
    func createEmptyGroup(){
        let newEmptyGroup = CounterGroup(name: "No group")
        modelContext.insert(newEmptyGroup)
    }
}
