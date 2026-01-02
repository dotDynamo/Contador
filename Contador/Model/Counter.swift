//
//  Counter.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/01.
//

import Foundation
import SwiftData

@Model
class Counter {
    var name: String
    var subtitle: String
    var emoji: String
    var count: Int
    
    init(name: String, subtitle: String = "", emoji: String, count: Int = 0) {
        self.name = name
        self.subtitle = subtitle
        self.emoji = emoji
        self.count = count
    }
}
