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
    
    @State var defaultGroup: CounterGroup?
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    if defaultGroup != nil{
                        NavigationLink(value: defaultGroup){
                            Text(defaultGroup!.name)
                        }
                    }
                    ForEach(groups){ group in
                        if !group.isDefault {
                            NavigationLink(value: group){
                                Text(group.name)
                            }
                        }
                    }
                    .onDelete { indexSet in
                                    indexSet.map { groups[$0] }.forEach(counterService.deleteGroup)
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
            .onAppear(){
                defaultGroup = counterService.getDefaultGroup()
            }
        }
    }
    
    func createEmptyGroup(){
        let newEmptyGroup = CounterGroup(name: "No group")
        modelContext.insert(newEmptyGroup)
    }
}
