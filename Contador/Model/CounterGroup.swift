//
//  CounterGroup.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/05.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class CounterGroup {
    var name: String
    @Relationship var counters: [Counter]
    var isPrivate: Bool
    var isDefault: Bool
    
    init(name: String = "", isDefault: Bool = false, isPrivate: Bool = false ) {
        self.name = name
        self.counters = []
        self.isPrivate = isPrivate
        self.isDefault = isDefault
    }
}
