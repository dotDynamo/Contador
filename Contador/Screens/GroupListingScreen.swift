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
    
    @State var showNewCounterSheet: Bool = false
    
    let counterService: CounterService
    let biometricService: BiometricService
    
    @State private var defaultGroup: CounterGroup?
    @State private var selectedGroup: CounterGroup?
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    if defaultGroup != nil{
                        Button {
                            if defaultGroup!.isPrivate {
                                Task {
                                    let success = await biometricService.authenticate()
                                    if success { selectedGroup = defaultGroup}
                                }
                            } else { selectedGroup = defaultGroup}
                        } label: {
                            HStack {
                                Text(defaultGroup!.name).foregroundStyle(.white)
                                if defaultGroup!.isPrivate {
                                    Spacer()
                                    Image(systemName: "lock").foregroundStyle(.gray)
                                }
                            }
                        }
                    }
                    ForEach(groups){ group in
                        if !group.isDefault {
                            Button {
                                if group.isPrivate {
                                    Task {
                                        let success = await biometricService.authenticate()
                                        if success { selectedGroup = group}
                                    }
                                } else { selectedGroup = group}
                            } label: {
                                HStack {
                                    Text(group.name).foregroundStyle(.white)
                                    if group.isPrivate {
                                        Spacer()
                                        Image(systemName: "lock").foregroundStyle(.gray)
                                    }
                                }
                            }
                        }
                    }
                    .onDelete { indexSet in
                                    indexSet.map { groups[$0] }.forEach(counterService.deleteGroup)
                    }
                }.navigationDestination(item: $selectedGroup) { group in
                    CounterListingScreen(group: group, counters: group.counters, counterService: counterService)
                }
            }
            .navigationTitle("Contador")
            .toolbar{
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
}
